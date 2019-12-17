From: Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v2 1/2] pwm: fine tune pwm-mtk-disp clock control flow
Date: Tue, 17 Dec 2019 10:42:02 +0800
Message-ID: <1576550522.19567.1.camel@mszsdaap41>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
 <20191216070123.114719-2-jitao.shi@mediatek.com>
 <20191216081843.yxe3vm674jwurwri@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191216081843.yxe3vm674jwurwri@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>, sj.huang@mediatek.com, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTE2IGF0IDA5OjE4ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8sDQo+IA0KPiBPbiBNb24sIERlYyAxNiwgMjAxOSBhdCAwMzowMToyMlBNICsw
ODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+ID4gTWF0Y2ggcHdtIGNsb2NrIHdoZW4gc3VzcGVuZCBh
bmQgcmVzdW1lLg0KPiA+IFByZXBhcmUgYW5kIGVuYWJsZSBkaXNwX3B3bSBjbG9jayB3aGVuIGRp
c3BfcHdtIGVuYWJsZS4NCj4gPiBEaXNhYmxlIGFuZCB1bnByZXBhcmUgZGlzcF9wd20gY2xvY2sg
d2hlbiBkaXNwX3B3bSBkaXNhYmxlLg0KPiANCj4gQXNzdW1pbmcgeW91IGNhdGNoZWQgYWxsIGNs
b2NrIG9wZXJhdGlvbnMgKEkgZGlkbid0IGNoZWNrKSwgdGhlIHBhdGNoDQo+IGxvb2tzIGZpbmUu
IFRoZSBjb21taXQgbG9nIGNvdWxkIGhvd2V2ZXIgYmUgaW1wcm92ZWQuIEFkZGl0aW9uYWwgdG8N
Cj4gZGVzY3JpYmluZyB3aGF0IHRoZSBwYXRjaCBkb2VzLCBzb21lIHdvcmRzIGFib3V0IHRoZSBt
b3RpdmF0aW9uIHdvdWxkIGJlDQo+IGdvb2QuIERvZXMgdGhpcyBmaXggYSBidWc/IElzIGl0IHRv
IHNhdmUgc29tZSBwb3dlciB3aGlsZSB0aGUgUFdNIGlzbid0DQo+IGluIHVzZT8NCj4gDQo+IEJl
c3QgcmVnYXJkcw0KPiBVd2UNCj4gDQoNCkknbGwgdXBkYXRlIHRoZSBjb21taXQgbXNnIG5leHQg
dmVyc2lvbi4NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KQmVzdCBSZWdhcmRzDQpKaXRh
bw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
