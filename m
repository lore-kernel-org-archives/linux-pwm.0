From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V12 0/5] Add i.MX7ULP EVK PWM backlight support
Date: Thu, 9 May 2019 13:29:13 +0000
Message-ID: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <0BFDBDD87FCB2A4DBC40095AB7F40CD8@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetre>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

aS5NWDdVTFAgRVZLIGJvYXJkIGhhcyBNSVBJLURTSSBkaXNwbGF5LCBpdHMgYmFja2xpZ2h0IGlz
IHN1cHBsaWVkIGJ5DQpUUE0gUFdNIG1vZHVsZSwgdGhpcyBwYXRjaCBzZXQgZW5hYmxlcyBpLk1Y
N1VMUCBUUE0gUFdNIGRyaXZlciBzdXBwb3J0DQphbmQgYWxzbyBhZGQgYmFja2xpZ2h0IHN1cHBv
cnQgZm9yIE1JUEktRFNJIGRpc3BsYXkuDQoNCkNoYW5nZXMgc2luY2UgVjExOg0KCS0gT05MWSBh
ZGQgYSBmdW5jdGlvbiBjb21tZW50IGluIGRyaXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMNCg0KQW5z
b24gSHVhbmcgKDUpOg0KICBkdC1iaW5kaW5nczogcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGJpbmRp
bmcNCiAgcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGRyaXZlciBzdXBwb3J0DQogIEFSTTogaW14X3Y2
X3Y3X2RlZmNvbmZpZzogQWRkIFRQTSBQV00gc3VwcG9ydCBieSBkZWZhdWx0DQogIEFSTTogZHRz
OiBpbXg3dWxwOiBBZGQgdHBtIHB3bSBzdXBwb3J0DQogIEFSTTogZHRzOiBpbXg3dWxwLWV2azog
QWRkIGJhY2tsaWdodCBzdXBwb3J0DQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14
LXRwbS1wd20udHh0ICAgICAgICB8ICAyMiArDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1l
dmsuZHRzICAgICAgICAgICAgICAgICAgfCAgMjAgKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDd1
bHAuZHRzaSAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsNCiBhcmNoL2FybS9jb25maWdzL2lt
eF92Nl92N19kZWZjb25maWcgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9wd20vS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKw0KIGRyaXZlcnMvcHdt
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJz
L3B3bS9wd20taW14LXRwbS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQ0OCArKysrKysr
KysrKysrKysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDUxMyBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14
LXRwbS1wd20udHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcHdtL3B3bS1pbXgtdHBt
LmMNCg0KLS0gDQoyLjcuNA0KDQo=
