Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795146479;
	b=QDxfDAQuAMUG4cCNzpSnYVD68w+yrsCg3GZHZfoqIziZ2clohynQkpyZQ8MsATYp0UJk
	 KmOrhn689lK3DfvoIkfenLrmSDOmteiMRxs9lklctkAyCP7w3PDXRFgdScwpteyYHtdVV
	 +m1JwiX+od4HRmV1VHk342PmXYHUMjspN8tN9T7pCg4QJN5cF/kQoJAzVCstlFMbnqGCt
	 NgCpKNwKk8+7yPG4xaiomm4t/DrCuwr7mryUEey3JZWgXRN8P2YTEpIPyecmZChxjylSO
	 KlUzPCxFKGCrOJhu4+hPW0wSYJR7Sc8x8awDcJ1YtQAhfJtGkEoUR9GRlqAuynON3vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146479;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qdqEqHGVw1OWCXQxDxaongHTpRkboAUMShHg0oRNY2Y=;
	b=5GNam48ivuiMB2AVlNqI/QkrgvQYYsksDldxnKji6zs4XYFQKd5ZRdNAyyLB3tqVljU6
	 SQUlGmXqNBpiCN/paN2pLNyIXH+9iDpRlP6ekFHxpRTfGPGQGbOI2OfvuOwuGDiYrAaRn
	 oHuVEf4DhnakWNqN8pDmkSbjw7BqehWFtcWIFiClDnFgToJPy+lDgkDrtjD1JMFdQMJXM
	 fpiWZWpaENvW27B0dcNkrF6U9BSO7eOKhk09OMzlxrbkbalRPKuyUhyhLgSxzrwxQa82+
	 HaI2wgTsEQ/b8soQDeWolrCDZ3ovghc++/1+uh7d150lpMCTNPU4FNqMRKbXGyZLMHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFnS7eiD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B48606A33F;
	Fri, 20 Nov 2026 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFnS7eiD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795146478;
	b=xTw1Aq8nAMxlAntiEjq99J3tUz6QChOIvQAzUZnnkyoJNGsxtNionoTfWsNARuOor9uY
	 qCh4rGpif+WSrBOfXux1UpsWRxc9s/R39O9GT5xzPbNR/grdBXkIbxyjR2sLzvT349OxH
	 mbtngeDn141zbJEgPb1aXEdL4/RyZAY2y0KEp82LMIH0FW199QCibVLW5Ma6ITvUNMMay
	 vqyX9ZN/1YRKN2k0Ow9AxCalZHyutPN2vrkb2RgcAHwSFKOpjMus0Yi6eTobPRyOdkJ0p
	 czeiCfCRreH++qTVvD6YXiaEx0Zpe7DJTnmUPEM8/HloR3ucDQGniJHdHmVeoXSBHQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795146478;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=qdqEqHGVw1OWCXQxDxaongHTpRkboAUMShHg0oRNY2Y=;
	b=GRtez5BQC4d9BIK1pNzktRGEXzvLy4tRqtg5mh4VG72UPkq0ncdEnXNyFQD5hkvGuNog
	 3iD1p/ZA8EL/tWx9p/7B1agYKmSJaSy855EN93ksF2KR0eiZJXOdZ7jwIlR995iz/14gr
	 Ho8PM5USrRppOZIiagapyUOXA7cVZXo4AumwkRkqpSxeqQgUWDTWZZ6cWkcKkmoNg54AV
	 dMVNWm4OfTnuT+9rzrBXeNbqIBDhM4c3KaiVWQk4pHLQi42NNJCEVhM6HdjVifMbAX9+Q
	 TMtFFCHX9USp9BRzbGt0azOp+F8DOs86RxmRln8H8UKjbAIoAvU+QjPdL/BRm1IsSIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1457B1F000CA;
	Fri, 20 Nov 2026 03:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146478;
	bh=qdqEqHGVw1OWCXQxDxaongHTpRkboAUMShHg0oRNY2Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VFnS7eiDFIvbwn2Z1Nsk1drf4qKmmn+9wdVyfi4tKPO0ardQxnZvFFmZNqMRqwIru
	 r2cDhie7gcsBYa/rBsiWs1Sd4TSUZCm1lV+YwlFxxXqUr7oq1QLPLbkdOuHgNwuXhN
	 gJRN56GZ+Zro54SZYZ34BZRQ0yjPjbhCVzSbwlO/cu3AsRsR1uzNg/UBjYlIbL+8UG
	 jwTuCohlkxquVyFrHE8iN/85BY0ocUScVEqlT1KGFg4t7VR2h4QuhZO6wIRn8THOvo
	 fdBdoVX1GPt2rJX4514r4kqQCbS5+16hHj4UDtmQ12MIrYpe2fqE6xNCF7fqKYqcJe
	 QRPR+b9ATn7Xg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9DA7A49585;
	Fri, 20 Nov 2026 03:47:57 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 20 Nov 2026 05:47:56 +0200
Subject: [PATCH] pwm: meson: Restore the registers after hibernation
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-pwm-meson-hib-v1-1-606e947b2c1f@iav.lv>
X-B4-Tracking: v=1; b=H4sIAOvC/2oC/x3MQQqAIBBA0avIrBvIgaK6SrTQnHIWmShUEN49a
 fkW/7+QOQlnmNQLiS/JcoYK3ShYvQk7o7hqoJZ6ranFeB94cD4DerFoBjey7cgxGahNTLzJ8//
 mpZQPMlWZmF8AAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=JOoyPeCQ7AebKuZzzp2MRiGi9mXQP+9Qpistecz8jTo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFn/D705s6n3fvJShpulGrb7l9lk+SrsyFnyslh6fd0x3
 S3p9xcVdpSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJCK5g+MOztfBx1UmLo0c3
 FB03X9HL0K4VyWBrlj/BRqLp6EIjZSaG/zX6vZzxqnxf/czXTmNL/BTPxvbw/pq/M27LuSV3NGk
 1MQAA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

When a hibernation image is restored after the system was powered off,
the PWM registers are reset. The channel clocks (mux, divider and gate)
are fields of REG_MISC_AB, and the clock framework still counts the gate
as enabled and the rate as set, so none of these fields is written
again. pwm-fan reconfigures its channel on resume, but that rewrites
only the counters and the enable bits, not the clock fields, and the
PWM core skips an unchanged state altogether. On ODROID-HC4 the fan
stays stopped after the restore.

Save REG_PWM_A, REG_PWM_B and REG_MISC_AB on suspend and write them back
on resume. pwm_AO_cd, which drives the VDDCPU regulator on this board,
is restored the same way.

Tested on ODROID-HC4: after two restores following a power cut, the fan
follows both manual pwm1 settings and the thermal control.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on a v7.3.5 based kernel, before the waveform API conversion, which did not change the clock handling relevant here; build-tested on pwm/for-next.
---
 drivers/pwm/pwm-meson.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 633b384358c0..c8fec42ae414 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -119,6 +119,8 @@ struct meson_pwm {
 	 * that is shared between the two PWMs.
 	 */
 	spinlock_t lock;
+	u32 saved_pwm[MESON_NUM_PWMS];
+	u32 saved_misc;
 };
 
 static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
@@ -732,13 +734,54 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to register PWM chip\n");
 
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+/*
+ * After a power loss the registers are reset, but the PWM core and the clock
+ * framework keep their state and skip unchanged writes.
+ */
+static int meson_pwm_suspend(struct device *dev)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	unsigned int i;
+
+	for (i = 0; i < MESON_NUM_PWMS; i++)
+		meson->saved_pwm[i] = readl(meson->base +
+					    meson_pwm_per_channel_data[i].reg_offset);
+	meson->saved_misc = readl(meson->base + REG_MISC_AB);
+
 	return 0;
 }
 
+static int meson_pwm_resume(struct device *dev)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&meson->lock, flags);
+	for (i = 0; i < MESON_NUM_PWMS; i++)
+		writel(meson->saved_pwm[i], meson->base +
+		       meson_pwm_per_channel_data[i].reg_offset);
+	writel(meson->saved_misc, meson->base + REG_MISC_AB);
+	spin_unlock_irqrestore(&meson->lock, flags);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(meson_pwm_pm_ops, meson_pwm_suspend,
+				meson_pwm_resume);
+
 static struct platform_driver meson_pwm_driver = {
 	.driver = {
 		.name = "meson-pwm",
 		.of_match_table = meson_pwm_matches,
+		.pm = pm_sleep_ptr(&meson_pwm_pm_ops),
 	},
 	.probe = meson_pwm_probe,
 };

---
base-commit: 3f9bd3ccc80af2684cfc0901757f85a78358cbab
change-id: 20261120-pwm-meson-hib-a8d9eb52de2a

Best regards,
-- 
Igor Velkov <iav@iav.lv>


