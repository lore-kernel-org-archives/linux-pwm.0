From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 0/2] clocks aren't disable when pwm_mtk_disp suspend
Date: Tue, 17 Dec 2019 12:02:35 +0800
Message-ID: <20191217040237.28238-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, sj.huang@mediatek.com, Jitao Shi <jitao.shi@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB0byB2MzoNCiAtIEFkZCBwcmVmaXggInB3bTogbXRrX2Rpc3AiIGluIGNv
bW1pdCBtc2cgdGl0bGUuDQoNCkNoYW5nZXMgc2luY2UgdG8gdjI6DQogLSBFZGl0IGNvbW1pdCBt
c2cuDQoNCkNoYW5nZXMgc2luY2UgdG8gdjE6DQogLSBFZGl0IGNvbW1pdCBtc2cuDQogLSBSZW1v
dmUgdGhlIHJlZ2lzdGVyIHRyaWdnZXIgaW4gcHJvYmUuDQogLSBSZWJhc2UgdG8gdjUuNS1yYzEu
DQoNCkNoYW5nZXMgaW4gcGF0Y2hlczoNCiAtIG1hdGNoIHB3bV9tdGtfZGlzcCBjbG9jayB3aGVu
IHN1c3BlbmQvcmVzdW1lDQogLSB0cmlnZ2VyIHB3bV9tdGtfZGlzcCByZWcgd29ya2luZyBhZnRl
ciBjb25maWcNCg0KSml0YW8gU2hpICgyKToNCiAgcHdtOiBtdGtfZGlzcDogZml4IHB3bSBjbG9j
a3Mgbm90IHBvd2Vyb2ZmIHdoZW4gZGlzYWJsZSBwd20NCiAgcHdtOiBtdGtfZGlzcDoga2VlcCB0
aGUgdHJpZ2dlciByZWdpc3RlciBhZnRlciBwd20gc2V0dGluZy4NCg0KIGRyaXZlcnMvcHdtL3B3
bS1tdGstZGlzcC5jIHwgNjMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQoNCi0t
IA0KMi4yMS4wDQo=
