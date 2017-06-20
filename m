Return-Path: <zhi.mao@mediatek.com>
From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH 2/4] pwm: mediatek: fix clk issue
Date: Tue, 20 Jun 2017 14:54:14 +0800
Message-ID: <1497941657-23876-3-git-send-email-zhi.mao@mediatek.com>
In-Reply-To: <1497941657-23876-1-git-send-email-zhi.mao@mediatek.com>
References: <1497941657-23876-1-git-send-email-zhi.mao@mediatek.com>
Return-Path: zhi.mao@mediatek.com
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="__=_Part_Boundary_007_1689701418.2082826669"
List-ID: <linux-pwm.vger.kernel.org>
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com

--__=_Part_Boundary_007_1689701418.2082826669
Content-Transfer-Encoding: base64
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_008_1159267317.1878223427"

--__=_Part_Boundary_008_1159267317.1878223427
Content-Type: text/html
Content-Transfer-Encoding: base64

PHByZT4NCjEuZml4IGNsb2NrIGNvbnRyb2wNCiAtIHByZXBhcmUgdG9wL21haW4gY2xrIGluIG10
a19wd21fcHJvYmUoKSBmdW5jdGlvbiwNCiAgIGl0IHdpbGwgaW5jcmVhc2UgcG93ZXIgY29uc3Vt
cHRpb24NCiAgIGFuZCBpbiBvcmlnaW5hbCBjb2RlIHRoZXNlIGNsb2NrcyBpcyBvbmx5IHByZXBl
YXJlIGJ1dCBuZXZlciBlbmFibGVkDQogLSBwd20gY2xvY2sgc2hvdWxkIGJlIGVuYWJsZWQgYmVm
b3JlIHNldHRpbmcgcHdtIHJlZ2lzdGVycw0KICAgaW4gZnVuY3Rpb246IG10a19wd21fY29uZmln
KCkNCg0KMi5maXggcHdtIHNvdXJjZSBjbG9jayBzZWxlY3Rpb24NCiAtIGluIG9yaWdpbmFsIGNv
ZGUsIHRoZSBwd20gb3V0cHV0IGZyZXF1ZW5jeSBpcyBub3QgY29ycmVjdA0KICAgd2hlbiBzZXQg
Yml0Jmx0OzMmZ3Q7PTEgdG8gUFdNQ09OIHJlZ2lzdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBaaGkg
TWFvICZsdDt6aGkubWFvQG1lZGlhdGVrLmNvbSZndDsNCi0tLQ0KIGRyaXZlcnMvcHdtL3B3bS1t
ZWRpYXRlay5jIHwgICA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jIGIvZHJpdmVycy9wd20v
cHdtLW1lZGlhdGVrLmMNCmluZGV4IDVjMTFiYzcuLmM4MDNmZjYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMN
CkBAIC0yLDYgKzIsNyBAQA0KICAqIE1lZGlhdGVrIFB1bHNlIFdpZHRoIE1vZHVsYXRvciBkcml2
ZXINCiAgKg0KICAqIENvcHlyaWdodCAoQykgMjAxNSBKb2huIENyaXNwaW4gJmx0O2Jsb2dpY0Bv
cGVud3J0Lm9yZyZndDsNCisgKiBDb3B5cmlnaHQgKEMpIDIwMTcgWmhpIE1hbyAmbHQ7emhpLm1h
b0BtZWRpYXRlay5jb20mZ3Q7DQogICoNCiAgKiBUaGlzIGZpbGUgaXMgbGljZW5zZWQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMNCiAgKiBMaWNlbnNlIHZlcnNpb24g
Mi4gVGhpcyBwcm9ncmFtIGlzIGxpY2Vuc2VkICZxdW90O2FzIGlzJnF1b3Q7IHdpdGhvdXQgYW55
DQpAQCAtNjEsNiArNjIsNDAgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgbXRrX3B3bV9jaGlwICp0
b19tdGtfcHdtX2NoaXAoc3RydWN0IHB3bV9jaGlwICpjaGlwKQ0KIAlyZXR1cm4gY29udGFpbmVy
X29mKGNoaXAsIHN0cnVjdCBtdGtfcHdtX2NoaXAsIGNoaXApOw0KIH0NCiANCitzdGF0aWMgaW50
IG10a19wd21fY2xrX2VuYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2
aWNlICpwd20pDQorew0KKwlzdHJ1Y3QgbXRrX3B3bV9jaGlwICpwYyA9IHRvX210a19wd21fY2hp
cChjaGlwKTsNCisJaW50IHJldCA9IDA7DQorDQorCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShw
Yy0mZ3Q7Y2xrc1tNVEtfQ0xLX1RPUF0pOw0KKwlpZiAocmV0ICZsdDsgMCkNCisJCXJldHVybiBy
ZXQ7DQorDQorCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShwYy0mZ3Q7Y2xrc1tNVEtfQ0xLX01B
SU5dKTsNCisJaWYgKHJldCAmbHQ7IDApIHsNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShwYy0m
Z3Q7Y2xrc1tNVEtfQ0xLX1RPUF0pOw0KKwkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlyZXQgPSBj
bGtfcHJlcGFyZV9lbmFibGUocGMtJmd0O2Nsa3NbTVRLX0NMS19QV00xICsgcHdtLSZndDtod3B3
bV0pOw0KKwlpZiAocmV0ICZsdDsgMCkgew0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBjLSZn
dDtjbGtzW01US19DTEtfTUFJTl0pOw0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBjLSZndDtj
bGtzW01US19DTEtfVE9QXSk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCXJldHVybiByZXQ7
DQorfQ0KKw0KK3N0YXRpYyB2b2lkIG10a19wd21fY2xrX2Rpc2FibGUoc3RydWN0IHB3bV9jaGlw
ICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtKQ0KK3sNCisJc3RydWN0IG10a19wd21fY2hp
cCAqcGMgPSB0b19tdGtfcHdtX2NoaXAoY2hpcCk7DQorDQorCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShwYy0mZ3Q7Y2xrc1tNVEtfQ0xLX1BXTTEgKyBwd20tJmd0O2h3cHdtXSk7DQorCWNsa19kaXNh
YmxlX3VucHJlcGFyZShwYy0mZ3Q7Y2xrc1tNVEtfQ0xLX01BSU5dKTsNCisJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKHBjLSZndDtjbGtzW01US19DTEtfVE9QXSk7DQorfQ0KKw0KIHN0YXRpYyBpbmxp
bmUgdTMyIG10a19wd21fcmVhZGwoc3RydWN0IG10a19wd21fY2hpcCAqY2hpcCwgdW5zaWduZWQg
aW50IG51bSwNCiAJCQkJdW5zaWduZWQgaW50IG9mZnNldCkNCiB7DQpAQCAtODEsNiArMTE2LDgg
QEAgc3RhdGljIGludCBtdGtfcHdtX2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVj
dCBwd21fZGV2aWNlICpwd20sDQogCXN0cnVjdCBjbGsgKmNsayA9IHBjLSZndDtjbGtzW01US19D
TEtfUFdNMSArIHB3bS0mZ3Q7aHdwd21dOw0KIAl1MzIgcmVzb2x1dGlvbiwgY2xrZGl2ID0gMDsN
CiANCisJbXRrX3B3bV9jbGtfZW5hYmxlKGNoaXAsIHB3bSk7DQorDQogCXJlc29sdXRpb24gPSBO
U0VDX1BFUl9TRUMgLyBjbGtfZ2V0X3JhdGUoY2xrKTsNCiANCiAJd2hpbGUgKHBlcmlvZF9ucyAv
IHJlc29sdXRpb24gJmd0OyA4MTkxKSB7DQpAQCAtOTEsMTAgKzEyOCwxMiBAQCBzdGF0aWMgaW50
IG10a19wd21fY29uZmlnKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2Ug
KnB3bSwNCiAJaWYgKGNsa2RpdiAmZ3Q7IDcpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCi0JbXRr
X3B3bV93cml0ZWwocGMsIHB3bS0mZ3Q7aHdwd20sIFBXTUNPTiwgQklUKDE1KSB8IEJJVCgzKSB8
IGNsa2Rpdik7DQorCW10a19wd21fd3JpdGVsKHBjLCBwd20tJmd0O2h3cHdtLCBQV01DT04sIEJJ
VCgxNSkgfCBjbGtkaXYpOw0KIAltdGtfcHdtX3dyaXRlbChwYywgcHdtLSZndDtod3B3bSwgUFdN
RFdJRFRILCBwZXJpb2RfbnMgLyByZXNvbHV0aW9uKTsNCiAJbXRrX3B3bV93cml0ZWwocGMsIHB3
bS0mZ3Q7aHdwd20sIFBXTVRIUkVTLCBkdXR5X25zIC8gcmVzb2x1dGlvbik7DQogDQorCW10a19w
d21fY2xrX2Rpc2FibGUoY2hpcCwgcHdtKTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTEw
MiwxMSArMTQxLDggQEAgc3RhdGljIGludCBtdGtfcHdtX2VuYWJsZShzdHJ1Y3QgcHdtX2NoaXAg
KmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20pDQogew0KIAlzdHJ1Y3QgbXRrX3B3bV9jaGlw
ICpwYyA9IHRvX210a19wd21fY2hpcChjaGlwKTsNCiAJdTMyIHZhbHVlOw0KLQlpbnQgcmV0Ow0K
IA0KLQlyZXQgPSBjbGtfcHJlcGFyZShwYy0mZ3Q7Y2xrc1tNVEtfQ0xLX1BXTTEgKyBwd20tJmd0
O2h3cHdtXSk7DQotCWlmIChyZXQgJmx0OyAwKQ0KLQkJcmV0dXJuIHJldDsNCisJbXRrX3B3bV9j
bGtfZW5hYmxlKGNoaXAsIHB3bSk7DQogDQogCXZhbHVlID0gcmVhZGwocGMtJmd0O3JlZ3MpOw0K
IAl2YWx1ZSB8PSBCSVQocHdtLSZndDtod3B3bSk7DQpAQCAtMTI0LDcgKzE2MCw3IEBAIHN0YXRp
YyB2b2lkIG10a19wd21fZGlzYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21f
ZGV2aWNlICpwd20pDQogCXZhbHVlICZhbXA7PSB+QklUKHB3bS0mZ3Q7aHdwd20pOw0KIAl3cml0
ZWwodmFsdWUsIHBjLSZndDtyZWdzKTsNCiANCi0JY2xrX3VucHJlcGFyZShwYy0mZ3Q7Y2xrc1tN
VEtfQ0xLX1BXTTEgKyBwd20tJmd0O2h3cHdtXSk7DQorCW10a19wd21fY2xrX2Rpc2FibGUoY2hp
cCwgcHdtKTsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBwd21fb3BzIG10a19wd21fb3Bz
ID0gew0KQEAgLTE1NiwxNCArMTkyLDYgQEAgc3RhdGljIGludCBtdGtfcHdtX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJcmV0dXJuIFBUUl9FUlIocGMtJmd0O2Nsa3Nb
aV0pOw0KIAl9DQogDQotCXJldCA9IGNsa19wcmVwYXJlKHBjLSZndDtjbGtzW01US19DTEtfVE9Q
XSk7DQotCWlmIChyZXQgJmx0OyAwKQ0KLQkJcmV0dXJuIHJldDsNCi0NCi0JcmV0ID0gY2xrX3By
ZXBhcmUocGMtJmd0O2Nsa3NbTVRLX0NMS19NQUlOXSk7DQotCWlmIChyZXQgJmx0OyAwKQ0KLQkJ
Z290byBkaXNhYmxlX2Nsa190b3A7DQotDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHBj
KTsNCiANCiAJcGMtJmd0O2NoaXAuZGV2ID0gJmFtcDtwZGV2LSZndDtkZXY7DQpAQCAtMTc0LDI2
ICsyMDIsMTUgQEAgc3RhdGljIGludCBtdGtfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCXJldCA9IHB3bWNoaXBfYWRkKCZhbXA7cGMtJmd0O2NoaXApOw0KIAlpZiAo
cmV0ICZsdDsgMCkgew0KIAkJZGV2X2VycigmYW1wO3BkZXYtJmd0O2RldiwgJnF1b3Q7cHdtY2hp
cF9hZGQoKSBmYWlsZWQ6ICVkXG4mcXVvdDssIHJldCk7DQotCQlnb3RvIGRpc2FibGVfY2xrX21h
aW47DQorCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQogCXJldHVybiAwOw0KLQ0KLWRpc2FibGVfY2xr
X21haW46DQotCWNsa191bnByZXBhcmUocGMtJmd0O2Nsa3NbTVRLX0NMS19NQUlOXSk7DQotZGlz
YWJsZV9jbGtfdG9wOg0KLQljbGtfdW5wcmVwYXJlKHBjLSZndDtjbGtzW01US19DTEtfVE9QXSk7
DQotDQotCXJldHVybiByZXQ7DQogfQ0KIA0KIHN0YXRpYyBpbnQgbXRrX3B3bV9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBtdGtfcHdtX2NoaXAgKnBj
ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQotCXVuc2lnbmVkIGludCBpOw0KLQ0KLQlm
b3IgKGkgPSAwOyBpICZsdDsgcGMtJmd0O2NoaXAubnB3bTsgaSsrKQ0KLQkJcHdtX2Rpc2FibGUo
JmFtcDtwYy0mZ3Q7Y2hpcC5wd21zW2ldKTsNCiANCiAJcmV0dXJuIHB3bWNoaXBfcmVtb3ZlKCZh
bXA7cGMtJmd0O2NoaXApOw0KIH0NCi0tIA0KMS43LjkuNQ0KDQo8L3ByZT48IS0tdHlwZTp0ZXh0
LS0+PCEtLXstLT48cHJlPioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGlj
ZQ0KICoqKioqKioqKioqKioqKioqKioqDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRo
aXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBhbnkgDQphdHRhY2htZW50cykgbWF5IGJlIGNv
bmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90aGVyd2lzZQ0KZXhlbXB0
IGZyb20gZGlzY2xvc3VyZSB1bmRlciBhcHBsaWNhYmxlIGxhd3MuIEl0IGlzIGludGVuZGVkIHRv
IGJlIA0KY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykuIEFueSB1
c2UsIGRpc3NlbWluYXRpb24sIA0KZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9y
IGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgDQphdHRhY2htZW50cykgYnkg
dW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IA0K
YmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlz
IGUtbWFpbCwgb3IgYmVsaWV2ZQ0KIA0KdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFp
bCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIA0KaW1tZWRpYXRlbHkgKGJ5IHJl
cGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiANCnRo
aXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBh
bmQgZG8gbm90DQpkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3Ro
ZXIgcGVyc29uLiBUaGFuaw0KIHlvdSE8L3ByZT48IS0tfS0tPg==

--__=_Part_Boundary_008_1159267317.1878223427
Content-Type: text/plain

1.fix clock control
 - prepare top/main clk in mtk_pwm_probe() function,
   it will increase power consumption
   and in original code these clocks is only prepeare but never enabled
 - pwm clock should be enabled before setting pwm registers
   in function: mtk_pwm_config()

2.fix pwm source clock selection
 - in original code, the pwm output frequency is not correct
   when set bit<3>=1 to PWMCON register.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |   69
 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 5c11bc7..c803ff6 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -2,6 +2,7 @@
  * Mediatek Pulse Width Modulator driver
  *
  * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2017 Zhi Mao <zhi.mao@mediatek.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -61,6 +62,40 @@ static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct
 pwm_chip *chip)
 	return container_of(chip, struct mtk_pwm_chip, chip);
 }
 
+static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device
 *pwm)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	int ret = 0;
+
+	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(pc->clks[MTK_CLK_MAIN]);
+	if (ret < 0) {
+		clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	if (ret < 0) {
+		clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
+		clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device
 *pwm)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+
+	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
+	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+}
+
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int
 num,
 				unsigned int offset)
 {
@@ -81,6 +116,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct
 pwm_device *pwm,
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
 	u32 resolution, clkdiv = 0;
 
+	mtk_pwm_clk_enable(chip, pwm);
+
 	resolution = NSEC_PER_SEC / clk_get_rate(clk);
 
 	while (period_ns / resolution > 8191) {
@@ -91,10 +128,12 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct
 pwm_device *pwm,
 	if (clkdiv > 7)
 		return -EINVAL;
 
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
+	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
 
+	mtk_pwm_clk_disable(chip, pwm);
+
 	return 0;
 }
 
@@ -102,11 +141,8 @@ static int mtk_pwm_enable(struct pwm_chip *chip, struct
 pwm_device *pwm)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	u32 value;
-	int ret;
 
-	ret = clk_prepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
-	if (ret < 0)
-		return ret;
+	mtk_pwm_clk_enable(chip, pwm);
 
 	value = readl(pc->regs);
 	value |= BIT(pwm->hwpwm);
@@ -124,7 +160,7 @@ static void mtk_pwm_disable(struct pwm_chip *chip,
 struct pwm_device *pwm)
 	value &= ~BIT(pwm->hwpwm);
 	writel(value, pc->regs);
 
-	clk_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	mtk_pwm_clk_disable(chip, pwm);
 }
 
 static const struct pwm_ops mtk_pwm_ops = {
@@ -156,14 +192,6 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 			return PTR_ERR(pc->clks[i]);
 	}
 
-	ret = clk_prepare(pc->clks[MTK_CLK_TOP]);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare(pc->clks[MTK_CLK_MAIN]);
-	if (ret < 0)
-		goto disable_clk_top;
-
 	platform_set_drvdata(pdev, pc);
 
 	pc->chip.dev = &pdev->dev;
@@ -174,26 +202,15 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto disable_clk_main;
+		return ret;
 	}
 
 	return 0;
-
-disable_clk_main:
-	clk_unprepare(pc->clks[MTK_CLK_MAIN]);
-disable_clk_top:
-	clk_unprepare(pc->clks[MTK_CLK_TOP]);
-
-	return ret;
 }
 
 static int mtk_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
-	unsigned int i;
-
-	for (i = 0; i < pc->chip.npwm; i++)
-		pwm_disable(&pc->chip.pwms[i]);
 
 	return pwmchip_remove(&pc->chip);
 }
-- 
1.7.9.5

--__=_Part_Boundary_008_1159267317.1878223427--

--__=_Part_Boundary_007_1689701418.2082826669--
