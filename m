From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Date: Wed, 18 Jul 2018 16:55:44 +0100
Message-ID: <20180718155544.GF4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
 <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCAxOCBKdWwgMjAxOCwgRGFuaWVsIFRob21wc29uIHdyb3RlOgoKPiBPbiBXZWQsIEp1
bCAxOCwgMjAxOCBhdCAwMjowODo1M1BNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4g
PiA+IE5vLCB0aGVuIHdlIGFyZSBiYWNrIHRvIHRoZSBpbml0aWFsIGlzc3VlIG9mIG51bV9zdGVw
cwo+ID4gPiA+ID4gPiBwb3RlbnRpYWxseSBub3QKPiA+ID4gPiA+ID4gYmVpbmcgaW5pdGlhbGlz
ZWQuIFdlIHJlYWxseSB3YW50IGJvdGggb2ZfcHJvcGVydHlfcmVhZF91MzIoKSB0bwo+ID4gPiA+
ID4gPiBzdWNjZWVkIEFORCBudW1fc3RlcHMgdG8gYWN0dWFsbHkgYmUgc2V0Lgo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBJIGFsc28gdGhpbmsgbnVtX3N0ZXBzIHNob3VsZCBiZSBwcmUtaW5pdGlhbGlz
ZWQuCj4gPiA+IAo+ID4gPiBZZXMsIEkgZ3Vlc3MgaXQgZGVmaW5pdGVseSBkb2VzIG5vdCBodXJ0
Lgo+ID4gPiAKPiA+ID4gPiA+IFRoZW4gaXQgd2lsbCBvbmx5IGJlIHNldCBpZiBvZl9wcm9wZXJ0
eV9yZWFkX3UzMigpIHN1Y2NlZWRzLgo+ID4gPiAKPiA+ID4gWWVzLCBidXQgd2Ugc3RpbGwgbmVl
ZCB0byBjaGVjayBmb3IgYm90aCwgdGhlIGZ1bmN0aW9uIG5vdCBmYWlsaW5nIGFuZAo+ID4gPiBu
dW1fc3RlcHMgdG8gYWN0dWFsbHkgYmUgbm9uIHplcm8uCj4gPiAKPiA+IFdoeT8gIFlvdSBkb24n
dCBkbyBhbnl0aGluZyBkaWZmZXJlbnRseSBpZiBpdCBmYWlscy4KPiAKPiBPbmx5IGlmIHlvdSBp
bml0aWFsaXplIG51bV9zdGVwcy4uLgo+IAo+IFdlIHNob3VsZCBlaXRoZXIgaW5pdGlhbGl6ZSB0
byB6ZXJvIGFuZCBub3Qgd29ycnkgYWJvdXQgdGhlIHJldHVybgo+IGNvZGVbMV0gb3Igd2UgY2hl
Y2sgdGhlIHJldHVybiBjb2RlIGFuZCBub3Qgd29ycnkgYWJvdXQKPiBpbml0aWFsaXphdGlvblsy
XS4gSSBkb24ndCB0aGluayBib3RoIGFyZSB3b3J0aHdoaWxlLgo+IAo+IFdoaWxzdCBpbml0aWFs
aXphdGlvbiBjYW4gZml4IHRoaXMgc3BlY2lmaWMgaW5zdGFuY2Ugd2UgZ2VuZXJhbGx5IGF2b2lk
Cj4gb3ZlcnVzaW5nIGl0IHNpbmNlIGl0IG1lc3NlcyB1cCBzdGF0aWMgYW5hbHlzaXMgYW5kLCBp
biB0aGlzIGluc3RhbmNlLAo+IGRpc3RhbmNlIGZyb20gZGVjbGFyYXRpb24gdG8gdXNlIGlzID4y
NSBsaW5lcywgaGVuY2UgY3VycmVudCBwYXRjaHNldC4KPiAKPiAKPiBEYW5pZWwuCj4gCj4gCj4g
WzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzcvMTYvMzk5Cj4gWzJdIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE4LzcvMTYvMTA0Mgo+IAo+IE9yLi4uCj4gCj4gV2UgY2hlY2sgdGhlIHJl
dHVybiBjb2RlIGFuZCBsZWF2ZSBudW1iZXIKPiAKPiBudW1fc3RlcHMgaXMgdW5pbml0aWFsaXpl
ZCBhbmQgc3RhY2sgYWxsb2NhdGVkIHNvIGl0IG9ubHkgaGFzIGEgdmFsaWQKPiB2YWx1ZSBpZiBv
Zl9wcm9wZXJ0eV9yZWFkX3UzMigpIHN1Y2NlZWRzLgo+IAo+IFdlIGNhbiAoYW5kIEkgb3JpZ2lu
YWxseSBkaWQpIGZpeCB0aGUgYnVnIGJ5IGluaXRpYWxpemluZyBudW1fc3RlcHMgdG8gMAo+IGJ1
dCBpdHMgcXVpdGUgc29tZSBkaXN0YW5jZSBiZXR3ZWVuIGRlY2xhcmF0aW9uIGFuZCB1c2Ugc28g
SSBhY2NlcHRlZAo+IE1hcmNlbCdzIGNvdW50ZXIgcHJvcG9zYWwgdG8gY2hlY2sgdGhlIHJldHVy
biBjb2RlIGluc3RlYWQuCgpPbmx5IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2Ygb2ZfcHJv
cGVydHlfcmVhZF91MzIoKSBpcyBhbHNvCnN1aXRhYmxlLgoKLS0gCkxlZSBKb25lcyBb5p2O55C8
5pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdp
dHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cg==
