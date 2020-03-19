From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Thu, 19 Mar 2020 14:57:07 +0200
Message-ID: <CAGgjyvFebxXaKkhy-UR1-kaYWozpP67YtVf5mp4mTHFQRhsjKg@mail.gmail.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
 <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
 <20200319121026.3rzcxdknfyhtkryi@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200319121026.3rzcxdknfyhtkryi@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org, Ludovic Desroches <ludovic.desroches@microchip.com>, bcm-kernel-feedback-list@broadcom.com, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Philippe Schenker <philippe.schenker@toradex.com>, Paul Barker <pbarker@konsulko.com>
List-Id: linux-pwm@vger.kernel.org

T24gVGh1LCBNYXIgMTksIDIwMjAgYXQgMjoxMSBQTSBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPgo+IEhlbGxvLAo+Cj4gW2Ryb3BwaW5n
IFRvbnkgUHJpc2sgPGxpbnV4QHByaXNrdGVjaC5jby5uej4gZnJvbSByZWNpcGllbnRzXQo+Cj4g
T24gVGh1LCBNYXIgMTksIDIwMjAgYXQgMDE6NDA6MjhQTSArMDIwMCwgT2xla3NhbmRyIFN1dm9y
b3Ygd3JvdGU6Cj4gPiBUaGllcnJ5LCBJIHNlZSB0aGUgUFdNIGNvcmUgY29udmVydHMgdGhlIGJp
dCBmaWVsZCAidGhpcmQgY2VsbCIgaW50bwo+ID4gdGhlIHBvbGFyaXR5IHZhcmlhYmxlLgo+ID4g
Tm93IEkgcHJvYmFibHkgdW5kZXJzdGFuZCB5b3VyIHNpZ2h0IGFuZCBhZ3JlZSB0aGF0IHdlIHNo
b3VsZG4ndCBnaXZlCj4gPiB0aGUgc2FtZSBuYW1lcyB0byBiaXRzIGluIGJpdGZpZWxkIChkdHMp
IGFuZCB2YWx1ZXMgb2YgYSB2YXJpYWJsZS4KPiA+Cj4gPiBCdXQgdGhlcmUgYXJlIGxvdHMgb2Yg
dXNlbGVzcyAiMCIgdmFsdWVzIG9mIHRoaXJkIGNlbGwgb2YgInB3bXMiCj4gPiBvcHRpb24gaW4g
ZHRzIGZpbGVzLgo+ID4KPiA+IEkgc2VlIDIgd2F5cyBub3c6Cj4gPiAtIGp1c3QgcmVtb3ZlIGFs
bCAiMCIgInRoaXJkIGNlbGwiIGZyb20gInB3bXMiIG9wdGlvbnMgaW4gZHRzIGZpbGVzLiBJCj4g
PiBzZWUgdGhpcyAiMCIgY29uZnVzZXMgc29tZSBwZW9wbGUuCj4KPiBUaGVuIHlvdSBoYXZlIHRv
IG92ZXJ3cml0ZSBwd20tY2VsbHMgb2YgdGhlIHByb3ZpZGVyLiBJZiB0aGVyZSBhcmUgdHdvCj4g
UFdNcyB1c2VkIGZyb20gdGhlIHNhbWUgcHJvdmlkZXIgYW5kIG9ubHkgb25lIGlzIGludmVydGVk
IHRoaXMgd29uJ3QKPiB3b3JrLiAoTm90IGVudGlyZWx5IHN1cmUgSSB1bmRlcnN0b29kIHlvdXIg
c3VnZ2VzdGlvbi4pIFNvIEkgZG9uJ3QgbGlrZQo+IHRoaXMgc3VnZ2VzdGlvbi4KCkdvb2QgcG9p
bnQsIGFncmVlLiBCdXQgd2Ugc3RpbGwgaGF2ZSB0aGUgdW5uYW1lZCAiMCIuCgpXaGF0IGFib3V0
IHJlbmFtaW5nIHRoZSBkdC1iaW5kaW5ncyBtYWNybyBQV01fUE9MQVJJVFlfSU5WRVJURUQKYW5k
IGFkZCB0aGUgbmV3IG9uZSBmb3IgdGhlIG5vcm1hbCBwb2xhcml0eT8KTGlrZSBQV01fRkxBR19Q
T0xBUklUWV9OT1JNQUwgLyBQV01fRkxBR19QT0xBUklUWV9JTlZFUlRFRCBvcgpEVF9QV01fUE9M
QVJJVFlfTk9STUFMIC8gRFRfUFdNX1BPTEFSSVRZX0lOVkVSVEVEPwoKVXNpbmcgZGlmZmVyZW50
IHByZWZpeCB3aWxsIHByZXZlbnQgaW50ZXJmZXJpbmcgbmFtZXMgb2YgZW51bSBhbmQKbWFjcm9z
IGluIHRoZSBmdXR1cmUKYW5kIHdpbGwgYWxsb3cgdXNpbmcgdGhlIG5hbWVkIG5vcC1mbGFnIFBX
TV9GTEFHX1BPTEFSSVRZX05PUk1BTCBpbiBkdHMuCgo+IEFuZCBhbHNvIGluIG15IGV5ZXMgdGhp
cyBpc24ndCBjbGVhcmVyLCBqdXN0IG1vcmUgY29tcGxpY2F0ZWQgdG8gdXNlLgo+Cj4gPiAtIGNv
bnZlcnQgcHdtX3N0YXRlLnBvbGFyaXR5IGludG8gcHdtX3N0YXRlLmZsYWdzIGFuZCB1c2UgYml0
ZmllbGQKPiA+ICAgZGlyZWN0bHkgZnJvbSBkdGIuCj4gPiAgIEl0IHNpbXBsaWZpZXMgdGhlIHBh
cnNpbmcgbG9naWMgYW5kIG1ha2VzIGFkZGluZyBuZXcgZmxhZ3MgZWFzaWVyLgo+Cj4gKnNocnVn
KiwgSSBkb24ndCBjYXJlIG11Y2guCj4KPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPgo+IC0tCj4gUGVu
Z3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEtsZWluZS1Lw7Zu
aWcgICAgICAgICAgICB8Cj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAg
ICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUvIHwKCgoKLS0gCkJlc3QgcmVnYXJkcwpP
bGVrc2FuZHIgU3V2b3JvdgoKVG9yYWRleCBBRwpFYmVuYXVzdHJhc3NlIDEwIHwgNjA0OCBIb3J3
IHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwIDQ4IDAwCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
