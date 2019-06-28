From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Date: Fri, 28 Jun 2019 08:55:16 +0100
Message-ID: <20190628075516.dwev7fxz7kmox2i2@holly.lan>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-5-mka@chromium.org>
 <20190626145617.GB22348@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190626145617.GB22348@xo-6d-61-c0.localdomain>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBKdW4gMjYsIDIwMTkgYXQgMDQ6NTY6MThQTSArMDIwMCwgUGF2ZWwgTWFjaGVrIHdy
b3RlOgo+IE9uIE1vbiAyMDE5LTA2LTI0IDEzOjMxOjEzLCBNYXR0aGlhcyBLYWVobGNrZSB3cm90
ZToKPiA+IENoZWNrIGlmIGEgYnJpZ2h0bmVzcyBjdXJ2ZSBzcGVjaWZpZWQgaW4gdGhlIGRldmlj
ZSB0cmVlIGlzIGxpbmVhciBvcgo+ID4gbm90IGFuZCBzZXQgdGhlIGNvcnJlc3BvbmRpbmcgcHJv
cGVydHkgYWNjb3JkaW5nbHkuIFRoaXMgbWFrZXMgdGhlCj4gPiBzY2FsZSB0eXBlIGF2YWlsYWJs
ZSB0byB1c2Vyc3BhY2UgdmlhIHRoZSAnc2NhbGUnIHN5c2ZzIGF0dHJpYnV0ZS4KPiA+IAo+ID4g
VG8gZGV0ZXJtaW5lIGlmIGEgY3VydmUgaXMgbGluZWFyIGl0IGlzIGNvbXBhcmVkIHRvIGEgaW50
ZXJwb2xhdGVkIGxpbmVhcgo+ID4gY3VydmUgYmV0d2VlbiBtaW4gYW5kIG1heCBicmlnaHRuZXNz
LiBUaGUgY3VydmUgaXMgY29uc2lkZXJlZCBsaW5lYXIgaWYKPiA+IG5vIHZhbHVlIGRldmlhdGVz
IG1vcmUgdGhhbiArLy01JSBvZiAke2JyaWdodG5lc3NfcmFuZ2V9IGZyb20gdGhlaXIKPiA+IGlu
dGVycG9sYXRlZCB2YWx1ZS4KPiAKPiBJIGRvbid0IHRoaW5rIHRoaXMgd29ya3MuIFNvbWUgaGFy
ZHdhcmUgZG9lcyB0YWtlcyBicmlnaHRuZXNzIGluIHBlcmNlcHR1YWwgdW5pdHMsCj4gY29udmVy
dGluZyBpdCBpbiB0aGUgTEVEIGNvbnRyb2xsZXIuCgpUaGlzIGNoZWNrIGlzIGV4Y2x1c2l2ZSB0
byBQV00gYmFja2xpZ2h0cyBzbyBJJ2QgbGlrZSB0byBkb3VibGUgY2hlY2sKdGhhdCB5b3UgYXJl
IHRoaW5raW5nIHNwZWNpZmljYWxseSBvZiBoYXJkd2FyZSB0aGF0IHRha2VzIGl0J3Mgc2lnbmFs
CmZyb20gdGhlIFBXTSBhbmQgd29ya3MgaW4gcGVyY2VwdHVhbCB1bml0cz8KCkkgZG9uJ3QgcmVj
YWxsIGFueSBleGFtcGxlcyBiZWluZyBvZmZlcmVkIHdoZW4gd2UgcmV2aWV3ZWQgdGhlCmF1dG8t
Z2VuZXJhdGVkIENJRSB0YWJsZXMgKGFsdGhvdWdoIHNpbmNlIHRoYXQgY2FuIGJlIG92ZXJyaWRl
biBieSBEVCBpdAp3YXMgbm90IG9mIHRoZSBzYW1lIGdyYXZpdHkgYW5kIHRoaXMgZXhhbXBsZSku
CgoKRGFuaWVsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
