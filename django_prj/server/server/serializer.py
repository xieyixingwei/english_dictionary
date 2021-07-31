from django.db.models import query
from rest_framework import serializers
from rest_framework.utils import html
from rest_framework.fields import empty
import re
from django.db import models
from collections import OrderedDict



class CustomSerializer(serializers.ModelSerializer):

    def __init__(self, instance=None, data=empty, **kwargs):
        if 'father' in kwargs.keys():
            self.father = kwargs.pop('father')
        super().__init__(instance, data, **kwargs)

    def to_representation(self, instance):
        response = super().to_representation(instance)
        print('++++++++++++++', self.__class__)#, self._pk(response))
        self._nested(response)
        print('--------------')#, self.__class__)
        print('')
        return response

    def _pk(self, response):
        if 'id' in response.keys():
            return response['id']
        return self.instance.pk

    def _set_repeat_null(self, member:str, response, father):
        fpks = []
        if isinstance(father.instance, list):
            fpks = [f.pk for f in father.instance]
        elif father.instance != None:
            fpks = [father.instance.pk]
        elif hasattr(father, 'fpk'):
            fpks = father.fpk if isinstance(father.fpk, list) else [father.fpk]
            print('****** 0.1')
        else:
            print('****** 0.2')

        if isinstance(response[member], list):
            for r in response[member]:
                if isinstance(r, OrderedDict):
                    pk = next(iter(r.items()))[1]
                    if pk in fpks:
                        response[member].remove(r)
                        #print('****** 1.1')
                elif r in fpks:
                    response[member].remove(r)
                    #print('****** 1.2')
                else:
                    print('****** 1.3', fpks, r)
        elif response[member] != None:
            if isinstance(response[member], OrderedDict):
                pk = next(iter(response[member].items()))[1]
                if pk in fpks:
                    response[member] = None
                    #print('****** 2.1')
            elif response[member] in fpks:
                response[member] = None
                #print('****** 2.2')
            else:
                #print('****** 2.3', fpks, response[member])
                response[member] = None
        else:
            print('****** 3')

    def _stop_recursion(self, member:str, response, memberSerializerType):
        father = self.father if hasattr(self, 'father') else None
        while father != None:
            if isinstance(father, memberSerializerType):
                self._set_repeat_null(member, response, father)
            if response[member] == None or (isinstance(response[member], list) and len(response[member]) == 0):
                return
            father = father.father if hasattr(father, 'father') else None

    def _nested(self, response):
        if not hasattr(self, 'nested'):
            return

        for k,memberSerializerType in self.nested().items():
            print('--- 1', k)#, memberSerializerType)

            self._stop_recursion(k, response, memberSerializerType)

            if response[k] == None or (isinstance(response[k], list) and len(response[k]) == 0):
                #print('****** 4')
                continue

            if isinstance(response[k], list):
                if isinstance(self.fields[k], serializers.ListSerializer):
                    #print('--- 2', k, memberSerializerType)
                    fatherpk = None
                    if hasattr(self, 'father') and isinstance(self.father, memberSerializerType):
                        fatherpk = self.father.instance.pk
                        #print('--- has father', fatherpk)
                    for r in response[k]:
                        pk = next(iter(r.items()))[1]
                        if pk == fatherpk:
                            response[k].remove(r)
                else:
                    pks = response.pop(k)
                    print('--- 3.1.1', pks)
                    queryset = self.fields[k].child_relation.get_queryset()
                    self.fpk = pks
                    
                    print('--- 3.1.1.1', [queryset.get(pk=pk) for pk in pks])
                    #try:
                    response[k] = [memberSerializerType(queryset.get(pk=pk), context=self.context, father=self).data for pk in pks]
                    #except Exception as e:
                    print('--- 3.1.2')#, e)

            elif self.instance == None:
                print('--- 3')
                pk = response.pop(k)
                queryset = self.fields[k].get_queryset()
                self.fpk = pk
                response[k] = memberSerializerType(queryset.get(pk=pk), context=self.context, father=self).data
            elif isinstance(self.instance, list) and len(self.instance) > 0 and issubclass(type(getattr(self.instance[0], k)), models.Model):
                #print('--- 4')
                response[k] = []
                for inst in self.instance:
                    initdata = getattr(inst, k)
                    response[k].append(memberSerializerType(initdata, context=self.context, father=self).data)
            elif issubclass(type(getattr(self.instance, k)), models.Model):
                #print('--- 5')
                initdata = getattr(self.instance, k)
                response[k] = memberSerializerType(initdata, context=self.context, father=self).data
            else:
                print('--- 6')

class CustomListSerializer(serializers.ListSerializer):

    def to_representation(self, data):
        #print('---- xxxxx', self.parent.__class__, self.child.__class__)
        self.child.father = self.parent
        return super().to_representation(data)
