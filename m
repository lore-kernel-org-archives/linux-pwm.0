From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Date: Wed, 18 Jul 2018 14:41:03 +0100
Message-ID: <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180718130853.GE4641@dell>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBKdWwgMTgsIDIwMTggYXQgMDI6MDg6NTNQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gPiA+ID4gTm8sIHRoZW4gd2UgYXJlIGJhY2sgdG8gdGhlIGluaXRpYWwgaXNzdWUgb2Yg
bnVtX3N0ZXBzCj4gPiA+ID4gPiBwb3RlbnRpYWxseSBub3QKPiA+ID4gPiA+IGJlaW5nIGluaXRp
YWxpc2VkLiBXZSByZWFsbHkgd2FudCBib3RoIG9mX3Byb3BlcnR5X3JlYWRfdTMyKCkgdG8KPiA+
ID4gPiA+IHN1Y2NlZWQgQU5EIG51bV9zdGVwcyB0byBhY3R1YWxseSBiZSBzZXQuCj4gPiA+ID4g
Cj4gPiA+ID4gSSBhbHNvIHRoaW5rIG51bV9zdGVwcyBzaG91bGQgYmUgcHJlLWluaXRpYWxpc2Vk
Lgo+ID4gCj4gPiBZZXMsIEkgZ3Vlc3MgaXQgZGVmaW5pdGVseSBkb2VzIG5vdCBodXJ0Lgo+ID4g
Cj4gPiA+ID4gVGhlbiBpdCB3aWxsIG9ubHkgYmUgc2V0IGlmIG9mX3Byb3BlcnR5X3JlYWRfdTMy
KCkgc3VjY2VlZHMuCj4gPiAKPiA+IFllcywgYnV0IHdlIHN0aWxsIG5lZWQgdG8gY2hlY2sgZm9y
IGJvdGgsIHRoZSBmdW5jdGlvbiBub3QgZmFpbGluZyBhbmQKPiA+IG51bV9zdGVwcyB0byBhY3R1
YWxseSBiZSBub24gemVyby4KPiAKPiBXaHk/ICBZb3UgZG9uJ3QgZG8gYW55dGhpbmcgZGlmZmVy
ZW50bHkgaWYgaXQgZmFpbHMuCgpPbmx5IGlmIHlvdSBpbml0aWFsaXplIG51bV9zdGVwcy4uLgoK
V2Ugc2hvdWxkIGVpdGhlciBpbml0aWFsaXplIHRvIHplcm8gYW5kIG5vdCB3b3JyeSBhYm91dCB0
aGUgcmV0dXJuCmNvZGVbMV0gb3Igd2UgY2hlY2sgdGhlIHJldHVybiBjb2RlIGFuZCBub3Qgd29y
cnkgYWJvdXQKaW5pdGlhbGl6YXRpb25bMl0uIEkgZG9uJ3QgdGhpbmsgYm90aCBhcmUgd29ydGh3
aGlsZS4KCldoaWxzdCBpbml0aWFsaXphdGlvbiBjYW4gZml4IHRoaXMgc3BlY2lmaWMgaW5zdGFu
Y2Ugd2UgZ2VuZXJhbGx5IGF2b2lkCm92ZXJ1c2luZyBpdCBzaW5jZSBpdCBtZXNzZXMgdXAgc3Rh
dGljIGFuYWx5c2lzIGFuZCwgaW4gdGhpcyBpbnN0YW5jZSwKZGlzdGFuY2UgZnJvbSBkZWNsYXJh
dGlvbiB0byB1c2UgaXMgPjI1IGxpbmVzLCBoZW5jZSBjdXJyZW50IHBhdGNoc2V0LgoKCkRhbmll
bC4KCgpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNy8xNi8zOTkKWzJdIGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDE4LzcvMTYvMTA0MgoKT3IuLi4KCldlIGNoZWNrIHRoZSByZXR1cm4g
Y29kZSBhbmQgbGVhdmUgbnVtYmVyCgpudW1fc3RlcHMgaXMgdW5pbml0aWFsaXplZCBhbmQgc3Rh
Y2sgYWxsb2NhdGVkIHNvIGl0IG9ubHkgaGFzIGEgdmFsaWQKdmFsdWUgaWYgb2ZfcHJvcGVydHlf
cmVhZF91MzIoKSBzdWNjZWVkcy4KCldlIGNhbiAoYW5kIEkgb3JpZ2luYWxseSBkaWQpIGZpeCB0
aGUgYnVnIGJ5IGluaXRpYWxpemluZyBudW1fc3RlcHMgdG8gMApidXQgaXRzIHF1aXRlIHNvbWUg
ZGlzdGFuY2UgYmV0d2VlbiBkZWNsYXJhdGlvbiBhbmQgdXNlIHNvIEkgYWNjZXB0ZWQKTWFyY2Vs
J3MgY291bnRlciBwcm9wb3NhbCB0byBjaGVjayB0aGUgcmV0dXJuIGNvZGUgaW5zdGVhZC4KCgpE
YW5pZWwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
