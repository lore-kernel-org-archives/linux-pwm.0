From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix heuristic to determine number of
 brightness levels
Date: Thu, 13 Jun 2019 08:43:57 -0700
Message-ID: <20190613154357.GN137143@google.com>
References: <20190612180003.161966-1-mka@chromium.org>
 <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMTE6MTQ6NTVBTSArMDIwMCwgRW5yaWMgQmFsbGV0Ym8g
aSBTZXJyYSB3cm90ZToKPiBIaSBNYXR0aGlhcywKPiAKPiBPbiAxMi82LzE5IDIwOjAwLCBNYXR0
aGlhcyBLYWVobGNrZSB3cm90ZToKPiA+IFdpdGggY29tbWl0IDg4YmE5NWJlZGI3OSAoImJhY2ts
aWdodDogcHdtX2JsOiBDb21wdXRlIGJyaWdodG5lc3Mgb2YKPiA+IExFRCBsaW5lYXJseSB0byBo
dW1hbiBleWUiKSB0aGUgbnVtYmVyIG9mIHNldCBiaXRzIChha2EgaHdlaWdodCgpKQo+ID4gaW4g
dGhlIFBXTSBwZXJpb2QgaXMgdXNlZCBpbiB0aGUgaGV1cmlzdGljIHRvIGRldGVybWluZSB0aGUg
bnVtYmVyCj4gPiBvZiBicmlnaHRuZXNzIGxldmVscywgd2hlbiB0aGUgYnJpZ2h0bmVzcyB0YWJs
ZSBpc24ndCBzcGVjaWZpZWQgaW4KPiA+IHRoZSBEVC4gVGhlIG51bWJlciBvZiBzZXQgYml0cyBk
b2Vzbid0IHByb3ZpZGUgYSByZWxpYWJsZSBjbHVlIGFib3V0Cj4gPiB0aGUgbGVuZ3RoIG9mIHRo
ZSBwZXJpb2QsIGluc3RlYWQgY2hhbmdlIHRoZSBoZXVyaXN0aWMgdG86Cj4gPiAKPiA+ICBubGV2
ZWxzID0gcGVyaW9kIC8gZmxzKHBlcmlvZCkKPiA+IAo+ID4gQWxzbyBsaW1pdCB0aGUgbWF4aW11
bSBudW1iZXIgb2YgYnJpZ2h0bmVzcyBsZXZlbHMgdG8gNDA5NiB0byBhdm9pZAo+ID4gZXhjZXNz
aXZlbHkgbGFyZ2UgdGFibGVzLgo+ID4gCj4gPiBXaXRoIHRoaXMgdGhlIG51bWJlciBvZiBsZXZl
bHMgaW5jcmVhc2VzIG1vbm90b25pY2FsbHkgd2l0aCB0aGUgUFdNCj4gPiBwZXJpb2QsIHVudGls
IHRoZSBtYXhpbXVtIG9mIDQwOTYgbGV2ZWxzIGlzIHJlYWNoZWQ6Cj4gPiAKPiA+IHBlcmlvZCAo
bnMpICAgICMgbGV2ZWxzCj4gPiAKPiA+IDEwMCAgICAJICAgICAgIDE2Cj4gPiA1MDAJICAgICAg
IDYyCj4gPiAxMDAwCSAgICAgICAxMTEKPiA+IDUwMDAJICAgICAgIDQxNgo+ID4gMTAwMDAJICAg
ICAgIDc2OQo+ID4gNTAwMDAJICAgICAgIDMzMzMKPiA+IDEwMDAwMAkgICAgICAgNDA5Ngo+ID4g
Cj4gPiBGaXhlczogODhiYTk1YmVkYjc5ICgiYmFja2xpZ2h0OiBwd21fYmw6IENvbXB1dGUgYnJp
Z2h0bmVzcyBvZiBMRUQgbGluZWFybHkgdG8gaHVtYW4gZXllIikKPiA+IFNpZ25lZC1vZmYtYnk6
IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3JnPgo+IAo+IFRlc3RlZCBvbiBTYW1z
dW5nIENocm9tZWJvb2sgUGx1cyAoMTYtYml0IHB3bSkKPiAKPiBUZXN0ZWQtYnk6IEVucmljIEJh
bGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+CgpUaGFua3MhCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
