From: <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 1/6] pwm: atmel: Add a hint where to find hardware
 documentation
Date: Mon, 26 Aug 2019 08:19:37 +0000
Message-ID: <be768ac4-fa2b-17f0-d98a-08617dea45d3@microchip.com>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
 <20190824001041.11007-2-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190824001041.11007-2-uwe@kleine-koenig.org>
Content-Language: en-US
Content-ID: <1FC23A5051CF2243A0273BC335043A30@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: uwe@kleine-koenig.org, Claudiu.Beznea@microchip.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gMjQvMDgvMjAxOSBhdCAwMjoxMCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEV4dGVy
bmFsIEUtTWFpbA0KPiANCj4gDQo+IE1vc3QgTWljcm9jaGlwIChmb3JtZXJseSBBdG1lbCkgY2hp
cHMgaGF2ZSBwdWJsaWNseSBhdmFpbGFibGUgbWFudWFscy4NCj4gQSBjb21wcmVoZW5zaXZlIGxp
c3QgaXMgYWxyZWFkeSBjb250YWluZWQgaW4gdGhlIGRvY3VtZW50YXRpb24gZm9sZGVyLg0KPiBS
ZWZlcmVuY2UgdGhpcyBsaXN0IGluIHRoZSBoZWFkZXIgb2YgdGhlIGRyaXZlciB0byBhbGxvdyBy
ZXZpZXdlcnMgdG8NCj4gZmluZCB0aGUgcmVsZXZhbnQgbWFudWFscy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+DQoNCkFja2Vk
LWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQpUaGFua3Mg
VXdlIQ0KDQpCZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCj4gLS0tDQo+IENoYW5nZXMgc2lu
Y2UgKGltcGxpY2l0KSB2MSBzZW50IHdpdGggTWVzc2FnZS1JZDoNCj4gMjAxOTA4MTUyMTQxMzMu
MTExMzQtMS11d2VAa2xlaW5lLWtvZW5pZy5vcmc6DQo+IA0KPiAgIC0gT25seSByZWZlcmVuY2Ug
RG9jdW1lbnRhdGlvbi9hcm0vbWljcm9jaGlwLnJzdCBpbnN0ZWFkIG9mIHN0YXJ0aW5nDQo+ICAg
ICBhbm90aGVyIGxpc3Qgb2YgbGlua3MNCj4gDQo+ICAgZHJpdmVycy9wd20vcHdtLWF0bWVsLmMg
fCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5j
DQo+IGluZGV4IGU1ZTFlYWYzNzJmYS4uYTYxYTMwZmE4YjdlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiBA
QCAtNCw2ICs0LDkgQEANCj4gICAgKg0KPiAgICAqIENvcHlyaWdodCAoQykgMjAxMyBBdG1lbCBD
b3Jwb3JhdGlvbg0KPiAgICAqCQkgQm8gU2hlbiA8dm9pY2Uuc2hlbkBhdG1lbC5jb20+DQo+ICsg
Kg0KPiArICogTGlua3MgdG8gcmVmZXJlbmNlIG1hbnVhbHMgZm9yIHRoZSBzdXBwb3J0ZWQgUFdN
IGNoaXBzIGNhbiBiZSBmb3VuZCBpbg0KPiArICogRG9jdW1lbnRhdGlvbi9hcm0vbWljcm9jaGlw
LnJzdC4NCj4gICAgKi8NCj4gICANCj4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+IA0KDQoN
Ci0tIA0KTmljb2xhcyBGZXJyZQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
