Return-Path: <zhi.mao@mediatek.com>
From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH 4/4] pwm: mediatek: add MT2712/MT7622 support
Date: Tue, 20 Jun 2017 14:54:16 +0800
Message-ID: <1497941657-23876-5-git-send-email-zhi.mao@mediatek.com>
In-Reply-To: <1497941657-23876-1-git-send-email-zhi.mao@mediatek.com>
References: <1497941657-23876-1-git-send-email-zhi.mao@mediatek.com>
Return-Path: zhi.mao@mediatek.com
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="__=_Part_Boundary_003_1444852209.1441050253"
List-ID: <linux-pwm.vger.kernel.org>
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com

--__=_Part_Boundary_003_1444852209.1441050253
Content-Transfer-Encoding: base64
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_004_2109115591.1605424124"

--__=_Part_Boundary_004_2109115591.1605424124
Content-Type: text/html
Content-Transfer-Encoding: base64

PHByZT4NCnN1cHBvcnQgbXVsdGlwbGUgY2hpcChNVDI3MTIsIE1UNzYyMiwgTVQ3NjIzKQ0KDQpT
aWduZWQtb2ZmLWJ5OiBaaGkgTWFvICZsdDt6aGkubWFvQG1lZGlhdGVrLmNvbSZndDsNCi0tLQ0K
IGRyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jIHwgICA2MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRl
ay5jIGIvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMNCmluZGV4IGM4MDNmZjYuLmQ1MjAzNTYg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy9w
d20vcHdtLW1lZGlhdGVrLmMNCkBAIC0xNiw2ICsxNiw3IEBADQogI2luY2x1ZGUgJmx0O2xpbnV4
L21vZHVsZS5oJmd0Ow0KICNpbmNsdWRlICZsdDtsaW51eC9jbGsuaCZndDsNCiAjaW5jbHVkZSAm
bHQ7bGludXgvb2YuaCZndDsNCisjaW5jbHVkZSAmbHQ7bGludXgvb2ZfZGV2aWNlLmgmZ3Q7DQog
I2luY2x1ZGUgJmx0O2xpbnV4L3BsYXRmb3JtX2RldmljZS5oJmd0Ow0KICNpbmNsdWRlICZsdDts
aW51eC9wd20uaCZndDsNCiAjaW5jbHVkZSAmbHQ7bGludXgvc2xhYi5oJmd0Ow0KQEAgLTMwLDYg
KzMxLDggQEANCiAjZGVmaW5lIFBXTURXSURUSAkJMHgyYw0KICNkZWZpbmUgUFdNVEhSRVMJCTB4
MzANCiANCisjZGVmaW5lIFBXTV9DTEtfRElWX01BWAkJNw0KKw0KIGVudW0gew0KIAlNVEtfQ0xL
X01BSU4gPSAwLA0KIAlNVEtfQ0xLX1RPUCwNCkBAIC0zOCwxMSArNDEsMTkgQEAgZW51bSB7DQog
CU1US19DTEtfUFdNMywNCiAJTVRLX0NMS19QV000LA0KIAlNVEtfQ0xLX1BXTTUsDQorCU1US19D
TEtfUFdNNiwNCisJTVRLX0NMS19QV003LA0KKwlNVEtfQ0xLX1BXTTgsDQogCU1US19DTEtfTUFY
LA0KIH07DQogDQotc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtdGtfcHdtX2Nsa19uYW1lW10g
PSB7DQotCSZxdW90O21haW4mcXVvdDssICZxdW90O3RvcCZxdW90OywgJnF1b3Q7cHdtMSZxdW90
OywgJnF1b3Q7cHdtMiZxdW90OywgJnF1b3Q7cHdtMyZxdW90OywgJnF1b3Q7cHdtNCZxdW90Oywg
JnF1b3Q7cHdtNSZxdW90Ow0KK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbXRrX3B3bV9jbGtf
bmFtZVtNVEtfQ0xLX01BWF0gPSB7DQorCSZxdW90O21haW4mcXVvdDssICZxdW90O3RvcCZxdW90
OywgJnF1b3Q7cHdtMSZxdW90OywgJnF1b3Q7cHdtMiZxdW90OywgJnF1b3Q7cHdtMyZxdW90Oywg
JnF1b3Q7cHdtNCZxdW90OywNCisJJnF1b3Q7cHdtNSZxdW90OywgJnF1b3Q7cHdtNiZxdW90Oywg
JnF1b3Q7cHdtNyZxdW90OywgJnF1b3Q7cHdtOCZxdW90Ow0KK307DQorDQorc3RydWN0IG10a19j
b21fcHdtX2RhdGEgew0KKwl1bnNpZ25lZCBpbnQgcHdtX251bXM7DQogfTsNCiANCiAvKioNCkBA
IC01NSw2ICs2NiwxMSBAQCBzdHJ1Y3QgbXRrX3B3bV9jaGlwIHsNCiAJc3RydWN0IHB3bV9jaGlw
IGNoaXA7DQogCXZvaWQgX19pb21lbSAqcmVnczsNCiAJc3RydWN0IGNsayAqY2xrc1tNVEtfQ0xL
X01BWF07DQorCWNvbnN0IHN0cnVjdCBtdGtfY29tX3B3bV9kYXRhICpkYXRhOw0KK307DQorDQor
c3RhdGljIGNvbnN0IHVuc2lnbmVkIGxvbmcgbXRrX3B3bV9jb21fcmVnW10gPSB7DQorCTB4MDAx
MCwgMHgwMDUwLCAweDAwOTAsIDB4MDBkMCwgMHgwMTEwLCAweDAxNTAsIDB4MDE5MCwgMHgwMjIw
DQogfTsNCiANCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBtdGtfcHdtX2NoaXAgKnRvX210a19wd21f
Y2hpcChzdHJ1Y3QgcHdtX2NoaXAgKmNoaXApDQpAQCAtOTksMTQgKzExNSwxNCBAQCBzdGF0aWMg
dm9pZCBtdGtfcHdtX2Nsa19kaXNhYmxlKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3
bV9kZXZpY2UgKnB3bSkNCiBzdGF0aWMgaW5saW5lIHUzMiBtdGtfcHdtX3JlYWRsKHN0cnVjdCBt
dGtfcHdtX2NoaXAgKmNoaXAsIHVuc2lnbmVkIGludCBudW0sDQogCQkJCXVuc2lnbmVkIGludCBv
ZmZzZXQpDQogew0KLQlyZXR1cm4gcmVhZGwoY2hpcC0mZ3Q7cmVncyArIDB4MTAgKyAobnVtICog
MHg0MCkgKyBvZmZzZXQpOw0KKwlyZXR1cm4gcmVhZGwoY2hpcC0mZ3Q7cmVncyArIG10a19wd21f
Y29tX3JlZ1tudW1dICsgb2Zmc2V0KTsNCiB9DQogDQogc3RhdGljIGlubGluZSB2b2lkIG10a19w
d21fd3JpdGVsKHN0cnVjdCBtdGtfcHdtX2NoaXAgKmNoaXAsDQogCQkJCSAgdW5zaWduZWQgaW50
IG51bSwgdW5zaWduZWQgaW50IG9mZnNldCwNCiAJCQkJICB1MzIgdmFsdWUpDQogew0KLQl3cml0
ZWwodmFsdWUsIGNoaXAtJmd0O3JlZ3MgKyAweDEwICsgKG51bSAqIDB4NDApICsgb2Zmc2V0KTsN
CisJd3JpdGVsKHZhbHVlLCBjaGlwLSZndDtyZWdzICsgbXRrX3B3bV9jb21fcmVnW251bV0gKyBv
ZmZzZXQpOw0KIH0NCiANCiBzdGF0aWMgaW50IG10a19wd21fY29uZmlnKHN0cnVjdCBwd21fY2hp
cCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCkBAIC0xMjUsOCArMTQxLDEwIEBAIHN0
YXRpYyBpbnQgbXRrX3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdt
X2RldmljZSAqcHdtLA0KIAkJY2xrZGl2Kys7DQogCX0NCiANCi0JaWYgKGNsa2RpdiAmZ3Q7IDcp
DQorCWlmIChjbGtkaXYgJmd0OyBQV01fQ0xLX0RJVl9NQVgpIHsNCisJCWRldl9lcnIoY2hpcC0m
Z3Q7ZGV2LCAmcXVvdDtwZXJpb2QgJWQgbm90IHN1cHBvcnRlZFxuJnF1b3Q7LCBwZXJpb2RfbnMp
Ow0KIAkJcmV0dXJuIC1FSU5WQUw7DQorCX0NCiANCiAJbXRrX3B3bV93cml0ZWwocGMsIHB3bS0m
Z3Q7aHdwd20sIFBXTUNPTiwgQklUKDE1KSB8IGNsa2Rpdik7DQogCW10a19wd21fd3JpdGVsKHBj
LCBwd20tJmd0O2h3cHdtLCBQV01EV0lEVEgsIHBlcmlvZF9ucyAvIHJlc29sdXRpb24pOw0KQEAg
LTE4MSwyMyArMTk5LDI4IEBAIHN0YXRpYyBpbnQgbXRrX3B3bV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoIXBjKQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQorCXBj
LSZndDtkYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZhbXA7cGRldi0mZ3Q7ZGV2KTsN
CisNCiAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAw
KTsNCiAJcGMtJmd0O3JlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJmFtcDtwZGV2LSZndDtk
ZXYsIHJlcyk7DQogCWlmIChJU19FUlIocGMtJmd0O3JlZ3MpKQ0KIAkJcmV0dXJuIFBUUl9FUlIo
cGMtJmd0O3JlZ3MpOw0KIA0KLQlmb3IgKGkgPSAwOyBpICZsdDsgTVRLX0NMS19NQVg7IGkrKykg
ew0KKwlmb3IgKGkgPSAwOyBpICZsdDsgcGMtJmd0O2RhdGEtJmd0O3B3bV9udW1zICsgMjsgaSsr
KSB7DQogCQlwYy0mZ3Q7Y2xrc1tpXSA9IGRldm1fY2xrX2dldCgmYW1wO3BkZXYtJmd0O2Rldiwg
bXRrX3B3bV9jbGtfbmFtZVtpXSk7DQotCQlpZiAoSVNfRVJSKHBjLSZndDtjbGtzW2ldKSkNCisJ
CWlmIChJU19FUlIocGMtJmd0O2Nsa3NbaV0pKSB7DQorCQkJZGV2X2VycigmYW1wO3BkZXYtJmd0
O2RldiwgJnF1b3Q7W1BXTV0gY2xvY2s6ICVzIGZhaWw6ICVsZFxuJnF1b3Q7LA0KKwkJCQltdGtf
cHdtX2Nsa19uYW1lW2ldLCBQVFJfRVJSKHBjLSZndDtjbGtzW2ldKSk7DQogCQkJcmV0dXJuIFBU
Ul9FUlIocGMtJmd0O2Nsa3NbaV0pOw0KKwkJfQ0KIAl9DQogDQotCXBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIHBjKTsNCi0NCiAJcGMtJmd0O2NoaXAuZGV2ID0gJmFtcDtwZGV2LSZndDtkZXY7
DQogCXBjLSZndDtjaGlwLm9wcyA9ICZhbXA7bXRrX3B3bV9vcHM7DQogCXBjLSZndDtjaGlwLmJh
c2UgPSAtMTsNCi0JcGMtJmd0O2NoaXAubnB3bSA9IDU7DQorCXBjLSZndDtjaGlwLm5wd20gPSBw
Yy0mZ3Q7ZGF0YS0mZ3Q7cHdtX251bXM7DQorDQorCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IHBjKTsNCiANCiAJcmV0ID0gcHdtY2hpcF9hZGQoJmFtcDtwYy0mZ3Q7Y2hpcCk7DQogCWlmIChy
ZXQgJmx0OyAwKSB7DQpAQCAtMjE1LDkgKzIzOCwyNSBAQCBzdGF0aWMgaW50IG10a19wd21fcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldHVybiBwd21jaGlwX3JlbW92
ZSgmYW1wO3BjLSZndDtjaGlwKTsNCiB9DQogDQorLyo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0qLw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2NvbV9wd21fZGF0
YSBtdDI3MTJfcHdtX2RhdGEgPSB7DQorCS5wd21fbnVtcyA9IDgsDQorfTsNCisNCitzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19jb21fcHdtX2RhdGEgbXQ3NjIyX3B3bV9kYXRhID0gew0KKwkucHdt
X251bXMgPSA2LA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfY29tX3B3bV9kYXRh
IG10NzYyM19wd21fZGF0YSA9IHsNCisJLnB3bV9udW1zID0gNSwNCit9Ow0KKy8qPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ki8NCisNCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBtdGtfcHdtX29mX21hdGNoW10gPSB7DQotCXsgLmNvbXBhdGlibGUg
PSAmcXVvdDttZWRpYXRlayxtdDc2MjMtcHdtJnF1b3Q7IH0sDQotCXsgfQ0KKwl7LmNvbXBhdGli
bGUgPSAmcXVvdDttZWRpYXRlayxtdDI3MTItcHdtJnF1b3Q7LCAuZGF0YSA9ICZhbXA7bXQyNzEy
X3B3bV9kYXRhfSwNCisJey5jb21wYXRpYmxlID0gJnF1b3Q7bWVkaWF0ZWssbXQ3NjIyLXB3bSZx
dW90OywgLmRhdGEgPSAmYW1wO210NzYyMl9wd21fZGF0YX0sDQorCXsuY29tcGF0aWJsZSA9ICZx
dW90O21lZGlhdGVrLG10NzYyMy1wd20mcXVvdDssIC5kYXRhID0gJmFtcDttdDc2MjNfcHdtX2Rh
dGF9LA0KKwl7fSwNCiB9Ow0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10a19wd21fb2ZfbWF0
Y2gpOw0KIA0KLS0gDQoxLjcuOS41DQoNCjwvcHJlPjwhLS10eXBlOnRleHQtLT48IS0tey0tPjxw
cmU+KioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlDQogKioqKioqKioq
KioqKioqKioqKioNClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVz
c2FnZSAoaW5jbHVkaW5nIGFueSANCmF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBw
cm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlDQpleGVtcHQgZnJvbSBkaXNjbG9z
dXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMgaW50ZW5kZWQgdG8gYmUgDQpjb252ZXll
ZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgZGlzc2VtaW5h
dGlvbiwgDQpkaXN0cmlidXRpb24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0
aGlzIGUtbWFpbCAoaW5jbHVkaW5nIGl0cyANCmF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJl
Y2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgDQpiZSB1bmxhd2Z1bC4g
SWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciBi
ZWxpZXZlDQogDQp0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgDQppbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhp
cyBlLW1haWwpLCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIA0KdGhpcyBlLW1haWwgKGlu
Y2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbyBub3QNCmRp
c2Nsb3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRo
YW5rDQogeW91ITwvcHJlPjwhLS19LS0+

--__=_Part_Boundary_004_2109115591.1605424124
Content-Type: text/plain

support multiple chip(MT2712, MT7622, MT7623)

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |   63
 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index c803ff6..d520356 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
@@ -30,6 +31,8 @@
 #define PWMDWIDTH		0x2c
 #define PWMTHRES		0x30
 
+#define PWM_CLK_DIV_MAX		7
+
 enum {
 	MTK_CLK_MAIN = 0,
 	MTK_CLK_TOP,
@@ -38,11 +41,19 @@ enum {
 	MTK_CLK_PWM3,
 	MTK_CLK_PWM4,
 	MTK_CLK_PWM5,
+	MTK_CLK_PWM6,
+	MTK_CLK_PWM7,
+	MTK_CLK_PWM8,
 	MTK_CLK_MAX,
 };
 
-static const char * const mtk_pwm_clk_name[] = {
-	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5"
+static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
+	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4",
+	"pwm5", "pwm6", "pwm7", "pwm8"
+};
+
+struct mtk_com_pwm_data {
+	unsigned int pwm_nums;
 };
 
 /**
@@ -55,6 +66,11 @@ struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	const struct mtk_com_pwm_data *data;
+};
+
+static const unsigned long mtk_pwm_com_reg[] = {
+	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
 };
 
 static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
@@ -99,14 +115,14 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip,
 struct pwm_device *pwm)
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int
 num,
 				unsigned int offset)
 {
-	return readl(chip->regs + 0x10 + (num * 0x40) + offset);
+	return readl(chip->regs + mtk_pwm_com_reg[num] + offset);
 }
 
 static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
 				  unsigned int num, unsigned int offset,
 				  u32 value)
 {
-	writel(value, chip->regs + 0x10 + (num * 0x40) + offset);
+	writel(value, chip->regs + mtk_pwm_com_reg[num] + offset);
 }
 
 static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -125,8 +141,10 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct
 pwm_device *pwm,
 		clkdiv++;
 	}
 
-	if (clkdiv > 7)
+	if (clkdiv > PWM_CLK_DIV_MAX) {
+		dev_err(chip->dev, "period %d not supported\n", period_ns);
 		return -EINVAL;
+	}
 
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
@@ -181,23 +199,28 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
+	pc->data = of_device_get_match_data(&pdev->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < MTK_CLK_MAX; i++) {
+	for (i = 0; i < pc->data->pwm_nums + 2; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
-		if (IS_ERR(pc->clks[i]))
+		if (IS_ERR(pc->clks[i])) {
+			dev_err(&pdev->dev, "[PWM] clock: %s fail: %ld\n",
+				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
 			return PTR_ERR(pc->clks[i]);
+		}
 	}
 
-	platform_set_drvdata(pdev, pc);
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = 5;
+	pc->chip.npwm = pc->data->pwm_nums;
+
+	platform_set_drvdata(pdev, pc);
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -215,9 +238,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+/*==========================================*/
+static const struct mtk_com_pwm_data mt2712_pwm_data = {
+	.pwm_nums = 8,
+};
+
+static const struct mtk_com_pwm_data mt7622_pwm_data = {
+	.pwm_nums = 6,
+};
+
+static const struct mtk_com_pwm_data mt7623_pwm_data = {
+	.pwm_nums = 5,
+};
+/*==========================================*/
+
 static const struct of_device_id mtk_pwm_of_match[] = {
-	{ .compatible = "mediatek,mt7623-pwm" },
-	{ }
+	{.compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data},
+	{.compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data},
+	{.compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data},
+	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
 
-- 
1.7.9.5

--__=_Part_Boundary_004_2109115591.1605424124--

--__=_Part_Boundary_003_1444852209.1441050253--
