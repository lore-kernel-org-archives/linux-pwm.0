From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/3] pwm/core: Try to get the module from
	pwm_get
Date: Mon, 30 Jan 2017 15:18:15 +0100
Message-ID: <7dd800b7-78c4-d6d1-4b8d-3cb575b9f71a@redhat.com>
References: <20170122161409.21601-1-hdegoede@redhat.com>
 <20170122161409.21601-3-hdegoede@redhat.com>
 <20170130081713.GM3585@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170130081713.GM3585@ulmo.ba.sec>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org

SGksCgpPbiAzMC0wMS0xNyAwOToxNywgVGhpZXJyeSBSZWRpbmcgd3JvdGU6Cj4gT24gU3VuLCBK
YW4gMjIsIDIwMTcgYXQgMDU6MTQ6MDhQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3cm90ZToKPj4g
QWRkIGEgbW9kdWxlX25hbWUgc3RyaW5nIHRvIHRoZSBwd21fbG9va3VwIHN0cnVjdCBhbmQgaWYg
c3BlY2lmaWVkCj4+IGFuZCBwd21jaGlwX2ZpbmRfYnlfbmFtZSgpIGRvZXMgbm90IGZpbmQgdGhl
IHB3bWNoaXAgdHJ5IGNhbGxpbmcKPj4gcmVxdWVzdF9tb2R1bGUgd2l0aCB0aGUgc3BlY2lmaWVk
IG5hbWUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhh
dC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9wd20vY29yZS5jICB8ICA0ICsrKysKPj4gIGluY2x1
ZGUvbGludXgvcHdtLmggfCAxMSArKysrKysrKystLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
d20vY29yZS5jIGIvZHJpdmVycy9wd20vY29yZS5jCj4+IGluZGV4IDBkM2VmMjkuLmM0MThhN2Eg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvcHdtL2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL3B3bS9j
b3JlLmMKPj4gQEAgLTgyMyw2ICs4MjMsMTAgQEAgc3RydWN0IHB3bV9kZXZpY2UgKnB3bV9nZXQo
c3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpjb25faWQpCj4+ICAJCXJldHVybiBFUlJf
UFRSKC1FTk9ERVYpOwo+Pgo+PiAgCWNoaXAgPSBwd21jaGlwX2ZpbmRfYnlfbmFtZShjaG9zZW4t
PnByb3ZpZGVyKTsKPj4gKwlpZiAoIWNoaXAgJiYgY2hvc2VuLT5tb2R1bGVfbmFtZSkgewo+PiAr
CQlyZXF1ZXN0X21vZHVsZShjaG9zZW4tPm1vZHVsZV9uYW1lKTsKPgo+IEhvdyBhYm91dCBjaGVj
a2luZyBmb3IgYW4gZXJyb3IgY29kZSBoZXJlPyBJdCdzIGtpbmQgb2YgcG9pbnRsZXNzIHRvIHRy
eQo+IGFnYWluIGlmIHRoZSBtb2R1bGUgZGlkbid0IGxvYWQgaW4gdGhlIGZpcnN0IHBsYWNlLiBO
byBuZWVkIHRvIHJlc3BpbiwgSQo+IGNhbiBtYWtlIHRoYXQgY2hhbmdlIGFzIEkgYXBwbHkuCgpT
dXJlLCB0aGF0IGlzIGZpbmUuCgpSZWdhcmRzLAoKSGFucwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9pbnRlbC1nZngK
