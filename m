From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 0/2] clocks don't disable when pwm_mtk_disp suspend
Date: Tue, 17 Dec 2019 11:04:36 +0800
Message-ID: <20191217030438.26657-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>
Cc: linux-mediatek@lists.infradead.org, sj.huang@mediatek.com, Jitao Shi <jitao.shi@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB0byB2MjoNCiAtIEVkaXQgY29tbWl0IG1zZy4NCg0KQ2hhbmdlcyBzaW5j
ZSB0byB2MToNCiAtIEVkaXQgY29tbWl0IG1zZy4NCiAtIFJlbW92ZSB0aGUgcmVnaXN0ZXIgdHJp
Z2dlciBpbiBwcm9iZS4NCiAtIFJlYmFzZSB0byB2NS41LXJjMS4NCg0KQ2hhbmdlcyBpbiBwYXRj
aGVzOg0KIC0gbWF0Y2ggcHdtX210a19kaXNwIGNsb2NrIHdoZW4gc3VzcGVuZC9yZXN1bWUNCiAt
IHRyaWdnZXIgcHdtX210a19kaXNwIHJlZyB3b3JraW5nIGFmdGVyIGNvbmZpZw0KDQpKaXRhbyBT
aGkgKDIpOg0KICBwd206IGZpeCBwd20gY2xvY2tzIG5vdCBwb3dlcm9mZiB3aGVuIGRpc2FibGUg
cHdtDQogIHB3bToga2VlcCB0aGUgdHJpZ2dlciByZWdpc3RlciBhZnRlciBwd20gc2V0dGluZy4N
Cg0KIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwgNjMgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNDQg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4wDQo=
