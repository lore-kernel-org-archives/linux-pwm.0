From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
	find the pwm_backlight
Date: Wed, 08 Mar 2017 11:40:02 +0200
Message-ID: <87varkhzt9.fsf@intel.com>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
 <20170120095519.GF17297@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170120095519.GF17297@lahna.fi.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

T24gRnJpLCAyMCBKYW4gMjAxNywgTWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAbGlu
dXguaW50ZWwuY29tPiB3cm90ZToKPiBPbiBGcmksIEphbiAyMCwgMjAxNyBhdCAxMDowMjo1MEFN
ICswMjAwLCBKYW5pIE5pa3VsYSB3cm90ZToKPj4gVGhhdCBzYWlkLCBJIHN1cHBvc2UgdGhlcmUg
Y291bGQgYmUgYW4gYWx0ZXJuYXRpdmUgdG8gaGFuZGxpbmcgcHdtX2dldCgpCj4+IGZhaWx1cmVz
IGF0IHByb2JlLiBXZSBjb3VsZCBqdXN0IGdvIG9uIHdpdGggb3VyIGluaXQsIGJ1dCBzY2hlZHVs
ZSBhCj4+IHJldHJ5IGxhdGVyLiBQZXJoYXBzIGEgYml0IGhhY2t5LCBidXQgaXQgd291bGQgYWRk
cmVzcyBib3RoIG9mIHRoZQo+PiBjb25jZXJucyBhYm92ZS4gQWdhaW4sIHRoaXMgcGF0Y2ggc2Vl
bXMgYSBzaW1wbGUgd29ya2Fyb3VuZCBpbiB0aGUgbWVhbgo+PiB0aW1lLgo+Cj4gTm90IHN1cmUg
aWYgdGhpcyB3b3JrcyBvciBob3cgaGFja3kgaXQgaXMsIGJ1dCBjYW4ndCB5b3UKPiByZXF1ZXN0
X21vZHVsZSgpIGJlZm9yZSB5b3Ugc3RhcnQgbG9va2luZyB1cCBmb3IgdGhlIHB3bT8KCkkgZXll
YmFsbGVkIHRoaXMgYSBsaXR0bGUsIGFuZCBub3RpY2VkOgoKZHJpdmVycy9hY3BpL2FjcGlfbHBz
cy5jOgoKc3RhdGljIHN0cnVjdCBwd21fbG9va3VwIGJzd19wd21fbG9va3VwW10gPSB7CglQV01f
TE9PS1VQX1dJVEhfTU9EVUxFKCI4MDg2MjI4ODowMCIsIDAsICIwMDAwOjAwOjAyLjAiLAoJCQkg
ICAgICAgInB3bV9iYWNrbGlnaHQiLCAwLCBQV01fUE9MQVJJVFlfTk9STUFMLAoJCQkgICAgICAg
InB3bS1scHNzLXBsYXRmb3JtIiksCn07Cgpkcml2ZXJzL21mZC9pbnRlbF9zb2NfcG1pY19jb3Jl
LmM6CgpzdGF0aWMgc3RydWN0IHB3bV9sb29rdXAgY3JjX3B3bV9sb29rdXBbXSA9IHsKCVBXTV9M
T09LVVAoImNyeXN0YWxfY292ZV9wd20iLCAwLCAiMDAwMDowMDowMi4wIiwgInB3bV9iYWNrbGln
aHQiLCAwLCBQV01fUE9MQVJJVFlfTk9STUFMKSwKfTsKClNob3VsZCBjcmNfcHdtX2xvb2t1cCBh
bHNvIHVzZSBQV01fTE9PS1VQX1dJVEhfTU9EVUxFPyBBbmQgd2hpY2ggbW9kdWxlCmV4YWN0bHk/
IHB3bV9nZXQoKSBkb2VzIGFuIGF1dG9tYXRpYyByZXF1ZXN0X21vZHVsZSgpLCBpZiB0aGUgbW9k
dWxlIGlzCmdpdmVuLgoKQW5kIHdpbGwgdGhpcyBzdGlsbCBiZSBlbm91Z2g/CgpCUiwKSmFuaS4K
CgotLSAKSmFuaSBOaWt1bGEsIEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBt
YWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
