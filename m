Return-path: <kernel-bounces@pengutronix.de>
From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Date: Fri, 12 Oct 2018 12:25:01 +0000
Message-ID: <3c0ec462-9f15-cbf2-51f6-5e7e70c68e48@ysoft.com>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo> <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
In-Reply-To: <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5236B51A1CB3F145828E79B884339D50@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm, 0, 
 period)
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Gavin Schenk <g.schenk@eckelmann.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

T24gMTIuMTAuMjAxOCAxMTo0NSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IE9uIFRodSwg
T2N0IDExLCAyMDE4IGF0IDAxOjE1OjQ0UE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0K
Pj4gVXdlLCBUaGllcnJ5LA0KDQpbLi4uXQ0KDQo+PiBJdCBpcyBhIFJGQyBhbmQgdGhlIHBhc3Qg
ZGlzY3Vzc2lvbiBhYm91dCBpdCB3YXMgbW9zdGx5IHRoZW9yZXRpY2FsIHRoYW4NCj4+IGFib3V0
IHRlY2huaWNhbCBkZXRhaWxzLiBTbyBJIHRob3VnaHQgdGhhdCBub2JvZHkgd291bGQgcmVhbGx5
IGV4cGVjdA0KPj4gZXhjZWxsZW50IHRlY2huaWNhbCBzb2x1dGlvbiBhdCB0aGlzIHBvaW50LiBJ
IGp1c3QgdHJpZWQgdG8gZG8gbXkgYmVzdA0KPj4gYW5kIHRlc3RlZCBkb3plbnMgb2YgdmFyaWF0
aW9ucyBvZiBbZW5hYmxlZC9kaXNhYmxlZC9pbnZlcnRlZC9ub24tDQo+PiBpbnZlcnRlZC8gYm9v
dGxvYWRlci9kZXZpY2UtdHJlZS9zeXNmc10gY29uZmlndXJhdGlvbnMgdG8gYmUgc3VyZSBob3cg
aXQNCj4+IGFmZmVjdHMgY3VycmVudCB1c2VycyBhbmQgaG93IGl0IGltcHJvdmVzIHRoZSBzaXR1
YXRpb24uDQo+IA0KPiBJIHJlcGxpZWQgdG8gdGhlIG1haWwgYW5kIHBvaW50ZWQgb3V0IGEgZmV3
IG90aGVyIHRoaW5ncyBub3cuIFRoaXMgaXMNCj4gZWFzaWVyIHRoYW4gdG8gdGFsayBhYm91dCB5
b3VyIHBhdGNoIGluIHRoaXMgZGlzY3Vzc2lvbi4NCg0KQWNrLg0KDQo+PiBSZWdhcmRpbmcgdGhl
IEdQSU8gb3V0cHV0IGNvbmZpZ3VyYXRpb24uIFllcywgdGhlIHBpbiBpcyBjb25maWd1cmVkIGFz
DQo+PiBpbnB1dCBpbiB0aGUgaW14X3B3bV9pbml0X3BpbmN0cmxfaW5mbygpIGZ1bmN0aW9uLiBB
dCB0aGlzIHN0YWdlIHlvdQ0KPj4gZG8gbm90IHJlYWxseSBrbm93IGhvdyB0byBjb25maWd1cmUg
dGhlIHBpbi4gQ29uZmlndXJpbmcgaXQgYXMgaW5wdXQNCj4+IGlzIHRoZSBzYWZlc3Qgb3B0aW9u
IEkgdGhpbmsuDQo+IA0KPiBEaWQgaXQgd29yayB3aXRob3V0IHNldHRpbmcgdGhlIGdwaW8gYXMg
b3V0cHV0IGluIHlvdXIgdGVzdHM/DQoNClllcywgSSBhbSB1c2luZyBpdCBsaWtlIHRoYXQgZm9y
IGFwcm94LiAyIG1vbnRocyB3aXRob3V0IGlzc3Vlcy4NCg0KPj4gSSB0aG91Z2h0IHRoYXQgdGhl
IHBpbiBpcyBjb25maWd1cmVkIGFzIG91dHB1dCB3aGVuZXZlciBncGlvZF9zZXRfdmFsdWUoKQ0K
Pj4gaXMgY2FsbGVkLiBOb25lIG9mIHRoZSBvdGhlciBleGFtcGxlcy91c2FnZXMgaW4ga2VybmVs
IEkgbG9va2VkIGF0IHVzZWQNCj4+IHRoZSBncGlvZF9kaXJlY3Rpb25fb3V0cHV0KCkNCj4gDQo+
IE1heWJlIHRoZXkgdXNlIGRldm1fZ3Bpb19yZXF1ZXN0X29uZSBvciBzaW1pbGFyIHRoYXQgcmV0
dXJuIHlvdXIgZ3BpbydzDQo+IGRpcmVjdGlvbiBhbHJlYWR5IGNvbmZpZ3VyZWQ/DQoNCk5vcGUu
IEV4YW1wbGVzIEkgbG9va2VkIGF0IChtYWlubHkgSTJDIHJlY292ZXJ5KSB1c2Ugb25seSB0aGUg
Z3Bpb2xpYg0KZnVuY3Rpb25zLg0KDQpNaWNoYWwNCg==
