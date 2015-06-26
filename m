From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
 control
Date: Fri, 26 Jun 2015 20:47:56 +0300
Message-ID: <20150626174756.GC5176@intel.com>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <20150626163137.GB30960@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20150626163137.GB30960@phenom.ffwll.local>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Linus Walleij <linus.walleij@linaro.org>, varkabhadram@gmail.com, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gRnJpLCBKdW4gMjYsIDIwMTUgYXQgMDY6MzE6MzdQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBGcmksIEp1biAyNiwgMjAxNSBhdCAwMjozMjowM1BNICswNTMwLCBTaG9iaGl0
IEt1bWFyIHdyb3RlOgo+ID4gSGksCj4gPiBOZXh0IHVwZGF0ZSBvZiB0aGUgc2VyaWVzIHJldmll
d2VkIGF0IAo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvNi8yMi8xNTUKPiA+IAo+ID4g
TWFqb3IgY2hhbmdlcyBhcmUgZmV3IHJldmlldyBjb21tZW50cyBmcm9tIFZhcmthIGFuZCBWaWxs
ZSBiZWluZyBhZGRyZXNzZWQuIEFsc28gZXhjZXB0Cj4gPiBmb3IgaW50ZWwtZ2Z4IHBhdGNoZXMs
IGFsbCBwYXRjaGVzIHJldmllc2lvbiBoaXN0b3J5IGlzIG1vdmVkIG91dCBvZiBjb21taXQgbWVz
c2FnZS4KPiA+IAo+ID4gSG9wZSB0aGlzIHNlcmllcyBmaW5hbGx5IGZpbmRzIGl0cyBtYXJrLgo+
ID4gCj4gPiBSZWdhcmRzCj4gPiBTaG9iaGl0Cj4gPiAKPiA+IFNob2JoaXQgS3VtYXIgKDcpOgo+
ID4gICBncGlvbGliOiBBZGQgc3VwcG9ydCBmb3IgcmVtb3ZpbmcgcmVnaXN0ZXJlZCBjb25zdW1l
ciBsb29rdXAgdGFibGUKPiA+ICAgbWZkOiBpbnRlbF9zb2NfcG1pY19jb3JlOiBBZGQgbG9va3Vw
IHRhYmxlIGZvciBQYW5lbCBDb250cm9sIGFzIEdQSU8KPiA+ICAgICBzaWduYWwKPiA+ICAgbWZk
OiBpbnRlbF9zb2NfcG1pY19jcmM6IEFkZCBQV00gY2VsbCBkZXZpY2UgZm9yIENyeXN0YWxjb3Zl
IFBNSUMKPiA+ICAgbWZkOiBpbnRlbF9zb2NfcG1pY19jb3JlOiBBREQgUFdNIGxvb2t1cCB0YWJs
ZSBmb3IgQ1JDIFBNSUMgYmFzZWQgUFdNCj4gPiAgIHB3bTogY3JjOiBBZGQgQ3J5c3RhbGNvdmUg
KENSQykgUFdNIGRyaXZlcgo+ID4gICBkcm0vaTkxNTogVXNlIHRoZSBDUkMgZ3BpbyBmb3IgcGFu
ZWwgZW5hYmxlL2Rpc2FibGUKPiA+ICAgZHJtL2k5MTU6IEJhY2tsaWdodCBjb250cm9sIHVzaW5n
IENSQyBQTUlDIGJhc2VkIFBXTSBkcml2ZXIKPiAKPiBJIHRoaW5rIHdlIGhhdmUgci1iL2Fja3Mg
b24gYWxsIHRoZSBwYXRjaGVzIG5vdy4gT2sgaWYgSSBwdWxsIHRoaXMgaW4KPiB0aHJvdWdoIGRy
bS1pbnRlbC5naXQgZm9yIDQuMz8gT3Igc2hvdWxkIEkgbWFrZSBhIHRvcGljIGJyYW5jaCB3aXRo
IHRhZwo+IGFuZCB0aGVuIHNlbmQgb3V0IHB1bGwgcmVxdWVzdHMgdG8gZXZlcnlvbmU/IE9yIHdp
bGwgZWFjaCBtYWludGFpbmVyIG1lcmdlCj4gb24gdGhlaXIgb3duIHNpbmNlIGl0J3MgYWxsIG9u
bHkgY291cGxlZCBhdCBydW50aW1lIGFueXdheT8gQW55IG9mIHRoZXNlCj4gd291bGQgc3VpdCBt
ZS4KCkkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCBJIGhhZCBhIGJ1aWxkIGZhaWx1cmUgZHVlIHRv
CmJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKCkgd2hlbiBJIHRyaWVkIHRoaXMgKGp1c3QgY2hhbmdl
ZCBpdCB0bwptb2R1bGVfcGxhdGZvcm1fZHJpdmVyKCkgdG8gZ2V0IHBhc3QgaXQpLiBTbyBJJ20g
bm90IHN1cmUgaWYgdGhpcwpub3cgZGVwZW5kcyBvbiBzb21lIHRyZWUgd2hpY2ggaXNuJ3QgaW5j
bHVkZWQgaW4gLW5pZ2h0bHkuLi4KCi0tIApWaWxsZSBTeXJqw6Rsw6QKSW50ZWwgT1RDCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWls
aW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
