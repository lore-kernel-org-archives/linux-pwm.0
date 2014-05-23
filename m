From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
Date: Fri, 23 May 2014 01:02:21 +0000
Message-ID: <08012c6e5240435ea1ce1836229f0b21@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1400717120.23867.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1lp0142.outbound.protection.outlook.com ([207.46.163.142]:24623
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796AbaEWBCZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 22 May 2014 21:02:25 -0400
In-Reply-To: <1400717120.23867.1.camel@phoenix>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

PiBTdWJqZWN0OiBbUEFUQ0hdIHB3bTogZnNsLWZ0bTogc2V0IHB3bV9jaGlwIGNhbl9zbGVlcCBm
bGFnDQo+IA0KPiBUaGUgaW1wbGVtZW50YXRpb24gb2YgLmNvbmZpZygpLCAuZW5hYmxlKCkgYW5k
IC5kaXNhYmxlKCkgb3BlcmF0aW9ucyBpbiB0aGlzDQo+IGRyaXZlciBtYXkgc2xlZXAsIHRodXMg
c2V0IHB3bV9jaGlwIGNhbl9zbGVlcCBmbGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBM
aW4gPGF4ZWwubGluQGluZ2ljcy5jb20+DQo+IC0tLQ0KDQpBY2tlZC1ieTogWGl1Ym8gTGkgPExp
LlhpdWJvQGZyZWVzY2FsZS5jb20+DQoNCkBUaGllcnJ5LA0KDQpUaGVyZSBhcmUgc3RpbGwgNCBw
YXRjaGVzIGJlZm9yZSB0aGlzIG9uZSwgYW5kIEknZCBsaWtlIHRvIGtub3cgdGhlIHN0YXR1cyBv
Zg0KdGhlbTogDQoJW1BBVENIdjIgMC80XSBGVE0gUFdNIGFkZHMgcmVnbWFwIGFuZCBlbmRpYW5u
ZXNzIHN1cHBvcnQuDQoNClRoYW5rcywNCg0KQlJzDQpYaXVibw0KDQoNCj4gIGRyaXZlcnMvcHdt
L3B3bS1mc2wtZnRtLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1mc2wtZnRtLmMgYi9kcml2ZXJzL3B3
bS9wd20tZnNsLWZ0bS5jDQo+IGluZGV4IDQyMDE2OWUuLmExOGJjOGYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcHdtL3B3bS1mc2wtZnRtLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWZzbC1m
dG0uYw0KPiBAQCAtNDU0LDYgKzQ1NCw3IEBAIHN0YXRpYyBpbnQgZnNsX3B3bV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWZwYy0+Y2hpcC5vZl9wd21fbl9jZWxscyA9
IDM7DQo+ICAJZnBjLT5jaGlwLmJhc2UgPSAtMTsNCj4gIAlmcGMtPmNoaXAubnB3bSA9IDg7DQo+
ICsJZnBjLT5jaGlwLmNhbl9zbGVlcCA9IHRydWU7DQo+IA0KPiAgCXJldCA9IHB3bWNoaXBfYWRk
KCZmcGMtPmNoaXApOw0KPiAgCWlmIChyZXQgPCAwKSB7DQo+IC0tDQo+IDEuOC4zLjINCj4gDQo+
IA0KDQo=
