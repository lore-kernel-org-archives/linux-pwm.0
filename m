From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/8] drivers/gpio/gpiolib: Add support for
 removing registered consumer lookup table
Date: Wed, 6 May 2015 17:09:49 +0200
Message-ID: <20150506150949.GM30184@phenom.ffwll.local>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
 <1430316005-16480-2-git-send-email-shobhit.kumar@intel.com>
 <CACRpkdbtu_J2vCZ2kKVhBX6J0Ptgx0UvbJo3jSf8s=8E2qf-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbtu_J2vCZ2kKVhBX6J0Ptgx0UvbJo3jSf8s=8E2qf-mw@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, Povilas Staniulis <wdmonster@gmail.com>, Johan Hovold <johan@kernel.org>, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBNYXkgMDYsIDIwMTUgYXQgMDQ6NDk6MzZQTSArMDIwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToKPiBPbiBXZWQsIEFwciAyOSwgMjAxNSBhdCAzOjU5IFBNLCBTaG9iaGl0IEt1bWFyIDxz
aG9iaGl0Lmt1bWFyQGludGVsLmNvbT4gd3JvdGU6Cj4gCj4gPiBJbiBjYXNlIHdlIHVubG9hZCBh
bmQgbG9hZCBhIGRyaXZlciBtb2R1bGUgYWdhaW4gdGhhdCBpcyByZWdpc3RlcmluZyBhCj4gPiBs
b29rdXAgdGFibGUsIHdpdGhvdXQgdGhpcyBpdCB3aWxsIHJlc3VsdCBpbiBtdWx0aXBsZSBlbnRy
aWVzLiBQcm92aWRlCj4gPiBhbiBvcHRpb24gdG8gcmVtb3ZlIHRoZSBsb29rdXAgdGFibGUgb24g
ZHJpdmVyIHVubG9hZAo+ID4KPiA+IHYyOiBDY2luZyBtYWludGFpbmVycwo+ID4KPiA+IENjOiBT
YW11ZWwgT3J0aXogPHNhbWVvQGxpbnV4LmludGVsLmNvbT4KPiA+IENjOiBMaW51cyBXYWxsZWlq
IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4gPiBDYzogQWxleGFuZHJlIENvdXJib3QgPGdu
dXJvdUBnbWFpbC5jb20+Cj4gPiBDYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdt
YWlsLmNvbT4KPiA+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgQ291cmJvdCA8YWNvdXJib3RAbnZp
ZGlhLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFNob2JoaXQgS3VtYXIgPHNob2JoaXQua3VtYXJA
aW50ZWwuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+CgpJIHRoaW5rIHRoZSBncGlvL3B3bSBhbmQgbWZkIHBhcnRzIHdvdWxkIGFs
bCBuZWVkIHRvIGdvIGluIHRocm91Z2ggdGhlCnNhbWUgdHJlZS4gaTkxNSBwYXJ0cyBhcmUgZGVj
b3VwbGVkLiBJIGd1ZXNzIEkgY291bGQgZG8gYSBicmFuY2ggd2l0aCBqdXN0CnRob3NlIHBhdGNo
ZXMsIHRhZyBpdCBhbmQgdGhlbiBzZW5kIGEgcHVsbCByZXF1ZXN0IHRvIGFsbCAzIHN1YnN5c3Rl
bXMKb25jZSBpdCdzIHJldmlld2VkLiBXb3VsZCB0aGF0IGJlIG9rPwotRGFuaWVsCi0tIApEYW5p
ZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxv
Zy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
