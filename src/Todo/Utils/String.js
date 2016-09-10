export function safeStringify (obj) {
  return JSON.stringify(obj)
    .replace(/<\/script/g, '<\\/script')
    .replace(/<!--/g, '<\\!--')
}
