import { MMKV } from '@tencent/mmkv';
import { JSON } from '@kit.ArkTS';

class MMKVDBUtil {
  newKV_bool(key: string, value: boolean) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeBool(key, value)
  }

  newKV_bool_set(key: string, value: boolean[]) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeBoolSet(key, value)
  }

  newKV_int(key: string, value: number) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeInt32(key, value)
  }

  newKV_double(key: string, value: number) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeDouble(key, value)
  }

  newKV_number_set(key: string, value: number[]) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeNumberSet(key, value)
  }

  newKV_string(key: string, value: string) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeString(key, value)
  }

  newKV_string_set(key: string, value: string[]) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeStringSet(key, value)
  }

  newKV_class(key: string, value: string) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeString(key, value)
  }

  newKV_class_set(key: string, value: string[]) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.encodeStringSet(key, value)
    console.log(`mmkv ${mmkv.decodeBool(key)}`)
  }

  get_int(key: string): number {
    let mmkv = MMKV.defaultMMKV()
    return mmkv.decodeInt32(key) ?? 0
  }

  get_double(key: string): number {
    let mmkv = MMKV.defaultMMKV()

    return mmkv.decodeDouble(key) ?? 0

  }

  get_number_set(key: string): number[] {
    let mmkv = MMKV.defaultMMKV()
    return mmkv.decodeNumberSet(key) ?? []
  }

  get_string(key: string): string {
    let mmkv = MMKV.defaultMMKV()
    return mmkv.decodeString(key) ?? 'KEY not find'


  }

  get_string_set(key: string): string[] {
    let mmkv = MMKV.defaultMMKV()
    let res = mmkv.decodeStringSet(key)
    console.log(`mmkv ${res}`)
    return res ?? []
  }

  get_class(key: string): object | null {
    let mmkv = MMKV.defaultMMKV()
    let js_string = mmkv.decodeString(key)
    let js = JSON.parse(js_string)
    return js
  }

  get_class_set(key: string): string[] {
    let mmkv = MMKV.defaultMMKV()
    let js_string = mmkv.decodeStringSet(key)
    console.log(`mmkv ${js_string}`)
    return js_string ?? []
  }

  delete_key(key: string) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.removeValueForKey(key)
  }

  delete_key_s(keys: string[]) {
    let mmkv = MMKV.defaultMMKV()
    mmkv.removeValuesForKeys(keys)
  }
}

let MMKVUtil = new MMKVDBUtil()

export default MMKVUtil as MMKVDBUtil