From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/3] acpi: lpss: call pwm_add_table() for
 bsw PWM device
Date: Mon, 30 Jan 2017 11:33:10 +0200
Message-ID: <20170130093310.GI17297@lahna.fi.intel.com>
References: <20170122161409.21601-1-hdegoede@redhat.com>
 <20170122161409.21601-4-hdegoede@redhat.com>
 <20170130081839.GN3585@ulmo.ba.sec>
 <CAJZ5v0hS08PX88+bXcnCz_V5f_VZ1L49iXnu9rHwDGO2uM7Q0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hS08PX88+bXcnCz_V5f_VZ1L49iXnu9rHwDGO2uM7Q0A@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCBKYW4gMzAsIDIwMTcgYXQgMDk6Mjg6MDlBTSArMDEwMCwgUmFmYWVsIEouIFd5c29j
a2kgd3JvdGU6Cj4gT24gTW9uLCBKYW4gMzAsIDIwMTcgYXQgOToxOCBBTSwgVGhpZXJyeSBSZWRp
bmcKPiA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPiB3cm90ZToKPiA+IE9uIFN1biwgSmFuIDIy
LCAyMDE3IGF0IDA1OjE0OjA5UE0gKzAxMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4gPj4gT24g
eDg2IHdlIGRvIG5vdCBoYXZlIGRldmljZXRyZWUgdG8gbGluayB0aGUgUFdNIGNvbnRyb2xsZXIg
YW5kCj4gPj4gdGhlIGRpc3BsYXkgY29udHJvbGxlciB0b2dldGhlci4gU28gc29tZW9uZSBuZWVk
cyB0byBjYWxsCj4gPj4gcHdtX2FkZF90YWJsZSgpIHRvIGNyZWF0ZSB0aGUgbGluaywgc28gdGhh
dCB0aGUgaTkxNSBkcml2ZXIncwo+ID4+IHB3bV9nZXQoZGV2LCAicHdtX2JhY2tsaWdodCIpIGNh
bGwgcmV0dXJucyB0aGUgbHBzcycgcHdtMC4KPiA+Pgo+ID4+IFRoZSBQV00gc3Vic3lzdGVtIGRv
ZXMgbm90IHdhbnQgdG8gaGF2ZSBwd21fYWRkX3RhYmxlKCkgY2FsbHMKPiA+PiBkaXJlY3RseSBp
biBQV00gZHJpdmVycyAodGhpcyBsZWFkcyB0byBwcm9iZSBvcmRlcmluZyBpc3N1ZXMpLAo+ID4+
IHNvIGxldHMgZG8gaXQgaGVyZSBzaW5jZSB0aGUgYWNwaS1scHNzIGNvZGUgaXMgYWx3YXlzIGJ1
aWx0aW4uCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPgo+ID4+IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdA
Z21haWwuY29tPgo+ID4+IC0tLQo+ID4+IENoYW5nZXMgaW4gdjI6Cj4gPj4gLVNldCBuZXcgcHdt
X2xvb2t1cCBtb2R1bGVfbmFtZSBmaWVsZCBpbiB0aGUgdGFibGUKPiA+PiAtLS0KPiA+PiAgZHJp
dmVycy9hY3BpL2FjcGlfbHBzcy5jIHwgMTMgKysrKysrKysrKysrKwo+ID4+ICAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IFJhZmFlbCwgZG8geW91IG1pbmQgaWYgSSB0
YWtlIHRoaXMgdGhyb3VnaCB0aGUgUFdNIHRyZWUgdG8gcmVzb2x2ZSB0aGUKPiA+IGJ1aWxkLXRp
bWUgZGVwZW5kZW5jeT8KPiAKPiBObywgSSBkb24ndCwgcGxlYXNlIGdvIGFoZWFkLCB1bmxlc3Mg
TWlrYS9BbmR5IHNlZSBhbnkgcHJvYmxlbXMgaW4gaXQuCgpObyBwcm9ibGVtcyBmcm9tIG15IHNp
ZGUgLSBsb29rcyBnb29kLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRl
bC1nZngK
