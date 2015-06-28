From: Shobhit Kumar <kumar@shobhit.info>
Subject: Re: [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
	control
Date: Sun, 28 Jun 2015 07:58:33 +0530
Message-ID: <CAAbrOmdLK+OOkcNH69MLGkvLLJmur14=hwokq0R0dWaNWYKvvw@mail.gmail.com>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <20150626163137.GB30960@phenom.ffwll.local>
 <20150626174756.GC5176@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20150626174756.GC5176@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Varka Bhadram <varkabhadram@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Brain WrecK <bloften80@gmail.com>, Povilas Staniulis <wdmonster@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Chih-Wei Huang <cwhuang@android-x86.org>
List-Id: linux-pwm@vger.kernel.org

T24gRnJpLCBKdW4gMjYsIDIwMTUgYXQgMTE6MTcgUE0sIFZpbGxlIFN5cmrDpGzDpAo8dmlsbGUu
c3lyamFsYUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOgo+IE9uIEZyaSwgSnVuIDI2LCAyMDE1IGF0
IDA2OjMxOjM3UE0gKzAyMDAsIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4+IE9uIEZyaSwgSnVuIDI2
LCAyMDE1IGF0IDAyOjMyOjAzUE0gKzA1MzAsIFNob2JoaXQgS3VtYXIgd3JvdGU6Cj4+ID4gSGks
Cj4+ID4gTmV4dCB1cGRhdGUgb2YgdGhlIHNlcmllcyByZXZpZXdlZCBhdAo+PiA+IGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDE1LzYvMjIvMTU1Cj4+ID4KPj4gPiBNYWpvciBjaGFuZ2VzIGFyZSBm
ZXcgcmV2aWV3IGNvbW1lbnRzIGZyb20gVmFya2EgYW5kIFZpbGxlIGJlaW5nIGFkZHJlc3NlZC4g
QWxzbyBleGNlcHQKPj4gPiBmb3IgaW50ZWwtZ2Z4IHBhdGNoZXMsIGFsbCBwYXRjaGVzIHJldmll
c2lvbiBoaXN0b3J5IGlzIG1vdmVkIG91dCBvZiBjb21taXQgbWVzc2FnZS4KPj4gPgo+PiA+IEhv
cGUgdGhpcyBzZXJpZXMgZmluYWxseSBmaW5kcyBpdHMgbWFyay4KPj4gPgo+PiA+IFJlZ2FyZHMK
Pj4gPiBTaG9iaGl0Cj4+ID4KPj4gPiBTaG9iaGl0IEt1bWFyICg3KToKPj4gPiAgIGdwaW9saWI6
IEFkZCBzdXBwb3J0IGZvciByZW1vdmluZyByZWdpc3RlcmVkIGNvbnN1bWVyIGxvb2t1cCB0YWJs
ZQo+PiA+ICAgbWZkOiBpbnRlbF9zb2NfcG1pY19jb3JlOiBBZGQgbG9va3VwIHRhYmxlIGZvciBQ
YW5lbCBDb250cm9sIGFzIEdQSU8KPj4gPiAgICAgc2lnbmFsCj4+ID4gICBtZmQ6IGludGVsX3Nv
Y19wbWljX2NyYzogQWRkIFBXTSBjZWxsIGRldmljZSBmb3IgQ3J5c3RhbGNvdmUgUE1JQwo+PiA+
ICAgbWZkOiBpbnRlbF9zb2NfcG1pY19jb3JlOiBBREQgUFdNIGxvb2t1cCB0YWJsZSBmb3IgQ1JD
IFBNSUMgYmFzZWQgUFdNCj4+ID4gICBwd206IGNyYzogQWRkIENyeXN0YWxjb3ZlIChDUkMpIFBX
TSBkcml2ZXIKPj4gPiAgIGRybS9pOTE1OiBVc2UgdGhlIENSQyBncGlvIGZvciBwYW5lbCBlbmFi
bGUvZGlzYWJsZQo+PiA+ICAgZHJtL2k5MTU6IEJhY2tsaWdodCBjb250cm9sIHVzaW5nIENSQyBQ
TUlDIGJhc2VkIFBXTSBkcml2ZXIKPj4KPj4gSSB0aGluayB3ZSBoYXZlIHItYi9hY2tzIG9uIGFs
bCB0aGUgcGF0Y2hlcyBub3cuIE9rIGlmIEkgcHVsbCB0aGlzIGluCj4+IHRocm91Z2ggZHJtLWlu
dGVsLmdpdCBmb3IgNC4zPyBPciBzaG91bGQgSSBtYWtlIGEgdG9waWMgYnJhbmNoIHdpdGggdGFn
Cj4+IGFuZCB0aGVuIHNlbmQgb3V0IHB1bGwgcmVxdWVzdHMgdG8gZXZlcnlvbmU/IE9yIHdpbGwg
ZWFjaCBtYWludGFpbmVyIG1lcmdlCj4+IG9uIHRoZWlyIG93biBzaW5jZSBpdCdzIGFsbCBvbmx5
IGNvdXBsZWQgYXQgcnVudGltZSBhbnl3YXk/IEFueSBvZiB0aGVzZQo+PiB3b3VsZCBzdWl0IG1l
Lgo+Cj4gSSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IEkgaGFkIGEgYnVpbGQgZmFpbHVyZSBkdWUg
dG8KPiBidWlsdGluX3BsYXRmb3JtX2RyaXZlcigpIHdoZW4gSSB0cmllZCB0aGlzIChqdXN0IGNo
YW5nZWQgaXQgdG8KPiBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyKCkgdG8gZ2V0IHBhc3QgaXQpLiBT
byBJJ20gbm90IHN1cmUgaWYgdGhpcwo+IG5vdyBkZXBlbmRzIG9uIHNvbWUgdHJlZSB3aGljaCBp
c24ndCBpbmNsdWRlZCBpbiAtbmlnaHRseS4uLgoKVGhlc2UgcGF0Y2hlcyBhcmUgYmFzZWQgb24g
bGludXgtbmV4dC9tYXN0ZXIKClJlZ2FyZHMKU2hvYmhpdApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
