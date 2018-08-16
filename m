From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 3/7] mfd: add atmel-lcdc driver
Date: Thu, 16 Aug 2018 09:42:10 +0100
Message-ID: <20180816084210.GB10054@dell>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell> <20180815204041.GA29041@ravnborg.org>
 <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gVGh1LCAxNiBBdWcgMjAxOCwgTmljb2xhcyBGZXJyZSB3cm90ZToKCj4gT24gMTUvMDgvMjAx
OCBhdCAyMjo0MCwgU2FtIFJhdm5ib3JnIHdyb3RlOgo+ID4gSGkgTGVlLgo+ID4gCj4gPiA+ID4g
Kwo+ID4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG1mZF9jZWxsIGxjZGNfY2VsbHNbXSA9IHsK
PiA+ID4gPiArCXsKPiA+ID4gPiArCQkubmFtZSA9ICJhdG1lbC1sY2RjLXB3bSIsCj4gPiA+ID4g
KwkJLm9mX2NvbXBhdGlibGUgPSAiYXRtZWwsbGNkYy1wd20iLAo+ID4gPiA+ICsJfSwKPiA+ID4g
PiArCXsKPiA+ID4gPiArCQkubmFtZSA9ICJhdG1lbC1sY2RjLWRjIiwKPiA+ID4gPiArCQkub2Zf
Y29tcGF0aWJsZSA9ICJhdG1lbCxsY2RjLWRpc3BsYXktY29udHJvbGxlciIsCj4gPiA+ID4gKwl9
LAo+ID4gPiA+ICt9Owo+ID4gPiAKPiA+ID4gV2lsbCB5b3UgYmUgYWRkaW5nIGFueSBtb3JlIGRl
dmljZXMsIG9yIGlzIHRoaXMgdGhlIGVudGlyZXR5IG9mIHRoZQo+ID4gPiBkZXZpY2U/ICBJZiB0
aGUgbGF0dGVyLCBJIHN1Z2dlc3QgdGhhdCB0aGlzIGRvZXNuJ3Qgd2FycmFudCBiZWluZyBhbgo+
ID4gPiBNRkQuCj4gPiBUaGF0cyBpdC4gQW5kIG90aGVycyBhZ3JlZSB3aXRoIHlvdSB0aGF0IHRo
aXMgaXMgbm90IGEgZ29vZCBhcHByb2FjaC4KPiA+IFNvIGluIHYyIHRoZXJlIHdpbGwgYmUgbm8g
TUZELgo+ID4gCj4gPiBUaGFua3MgZm9yIGNvbmZpcm1pbmcgdGhhdCB0aGUgbm9uLW1mZCB3YXkg
aXMgdGhlIGJldHRlciBhcHByb2FjaC4KPiAKPiBNRkQgYXBwcm9hY2ggd291bGQgaGF2ZSBoYWQg
dGhlIGJlbmVmaXQgb2Yga2VlcGluZyB0aGlzIGRyaXZlciBzZXJpZXMKPiBhcmNoaXRlY3R1cmUg
Y2xvc2UgdG8gdGhlIEhMQ0Qgb25lLiBUaGlzIHdvdWxkIGhhdmUgYmVlbiBlYXNpZXIgdG8KPiB1
bmRlcnN0YW5kIGFuZCB1c2Ugb25lIFNvQyBvciBhbm90aGVyIG9uZSBmcm9tIHRoZSBBVDkxIHBy
b2R1Y3QgbGluZS4uLi4KClllcywgdGhhdCBpcyB0cnVlLiAgVGhleSBhcmUgdmVyeSBzaW1pbGFy
IGRyaXZlcnMuICBXb3VsZCBpdCBtYWtlCnNlbnNlIHRvIHVzZSB0aGUgc2FtZSBkcml2ZXIgZm9y
IGJvdGggZGV2aWNlcz8KCj4gQW55d2F5LCBJJ2Qgd2FpdCBmb3IgQm9yaXMnIGZlZWRiYWNrIGZv
ciBtYWtpbmcgYSBkZWNpc2lvbi4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNl
cnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
