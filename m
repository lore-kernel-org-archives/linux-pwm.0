Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801214;
	b=rf8ZgnRgICCgFCUr0B/ofCGhfURfKhOKsBaF0GBI28MHvqtqFYVfRYMzqvgx/mLP+pTE
	 vSniDwJPEo2aba+0X51qlKgsMKGd8FnhGe2o7jrL2EhLdGsNPIjRgzwXO+k2WxHg2h2Ij
	 Sya6XBkNTfLoNyfiNJAC0V6RudpLynrogHfkFW0DOgvtdW8o5KFIvxstNoOvlN+XurI84
	 tM3YpCAgouNRU+yhFYid0Ve7l559JzmKx/N0wXD+dD0M9ny8l982R2oDJ415vMMk/RABA
	 5kTzO3/JEcBj8E28MAvXiXlRt/OPzX/KmNS64SeLRacQQbS/NkVIFhXIjxFew9U9CHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=QO1WMSUsoU7d4+vr/dMAYRmW9+EjtD97ziyOCmzqtAw=;
	b=1jCK5Wof7T3mKHemkdA1upyEn2htHbNsm/ywwUFQuHBU51VVJDJH6q4/b5VoH6o/Wrj/
	 VNAKIQbE8OCVyu8p3QnMbR6jL8e1RuSAbAezBCF1xM3n7Az75ZK4JgGh+tDEe7hZm+7ca
	 8gXznaxyGGvKztk33tXeWT59D8pVm/EwN8CaStUsOtgiHZVXd+a2U3iznIY39CfyO+QX0
	 et+f+ny5q+b7UDS4lYPd1BZOi2fi+hTEoacfvpMShYnWCF19Q6FZApttbx+Dp3JU97UJV
	 IuIQQ1RLo78pPWQd9KmdKz+UzL4RltLp74MX4pBX8T+f8rcppB7KQ4/bqBkKEIbRx5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NEcjCA5k;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78A606A32F
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 17:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D78A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NEcjCA5k
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so5364637f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795801212; x=1796406012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QO1WMSUsoU7d4+vr/dMAYRmW9+EjtD97ziyOCmzqtAw=;
        b=NEcjCA5kQNjo9s+AnKKJpIRZpyKuDNJLX/AhwnHh2pCizzUdyeDknE2stQ+NKqqncT
         SpoWUyhQcXs2NlHtI3L33xvHIZuscjeugEuqQfD1xAyWJn4pSLKJ9drP0TLRhKndTUKq
         u+Y0TTHvts5q+26IHDncmGh5JpMjv2U4QuJjTzFh88tRiFRAgTs6lR3UMEjlPbXf9n7M
         u8w8HrfHE8j3e5UZr9FtweIKeyX1kbxruhs+VD1Zi3zm258R3idTNOtZctjqsRKHqz9f
         ee7rQA8q4B6AVyKGYwsTPQRVC0yP1G5In/ukjiREhNP2E4PUEpJh5IOhK161EkpKOmtH
         CUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801212; x=1796406012;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QO1WMSUsoU7d4+vr/dMAYRmW9+EjtD97ziyOCmzqtAw=;
        b=UvpvhsZIVzrjWGxN97NF59RC8kM7IXpr9QzT30sso3RfLEClWvhbcdIKOyE8md6CZ5
         ZaIcitSQUXqE2vxOecUydD7A0V5ycjZ5v1B0WTYDD/E+mE9wgUYCLMu9hKxEoajFLVTI
         uxlJNsS4tHuo2Kaja82lKhi2nQadGlr5yRZAfBIP/Y3/GJqy1hr71/GafDMexHzfaxlA
         CZ4EThf6iOMxCvLxYuISD9Ms3sy2Ye5cZ7PM7Z24sIYJEBEMD3mDk8EO/OdqgqTWVX+7
         esqtM80hYuVB7PMYVDgH0T8DUEh98T1rofLAVmIruZ9SSCXXsx7IzNQImnOBcTT9aLce
         /Lfg==
X-Gm-Message-State: APuU4Z/v689niIMEzILNE8maTdLfK85VLuOZfOqGyjPmMeey/apujxzJ
	4V6C6bstkyz8df8DdMgxwNeNbQ8pdGm/GiURTKio1Cwya/CrW+nLs0wmDPKyFZBpVNNstj9nlKJ
	SYO3bpAI=
X-Gm-Gg: AZFdTZeBXUT8PvbaA11oSJU/8qWnNSG/22r0xQmu0k+uaxr41rR52AFhDJYKbUwIp1p
	J8i81eA2+RHOTOkIrm2WjbkCq7Ry6WnG2lopWu9In9TlDq1Vrpqmf1DcN/wFg9Se/4DRxmKIjXz
	7l8KaIJ6YbxWPKbshsPGeMrgwmGWyxuer0ulJxp5D3g16R4J1OBYUQqnSLJ9DHdVvcYKJlC0Aaw
	TRWpI515xjroMMvRlkyxwrhIOvX4YC/4NCP7zY1LjjehxR4eiGeyDVLwIrd+DT52x89LIoHz0RC
	e47TR+w/e7G6+94wYmXLRhChGcUMh1qbhBgmDffF/Eir/OjCTPzZRsl5RzlTzXJtl/l6LI79Xks
	uHA7BrMEDy9k4SP4Uv+cpeQYEg0mEw5Nu7PPfGiiZgLtXDCwumRxgA6jRreZvIfBODDatAPMJIP
	h7TtIeb7nDOFW0StHeuMw1M+q5KWOQP6/sKGTHUMz75WPKil+7xZy1cgUsAuT6iFMHI3xhH28+U
	aF+XdLqScvVP77i+cEXv/bdpFtaSIHtZ4U6DOrv23tht8T71YmUHjm9Po1iYM8D1EaH1zhp+baZ
	msnEHLgsmdKlkfCqn4uLAJlCpNOHosLE3Fampxu2ignuM8ns2iT1mYp95V4fFQKGIKCOQEBorDj
	cnqmN+aXl1Ftdytez8SVAZeSGhINHMNVXqU0IDQ==
X-Received: by 2002:a05:600c:e553:b0:4bb:9457:3c93 with SMTP id 5b1f17b1804b1-4bb94573c9amr313939755e9.2.1795801212019;
        Fri, 27 Nov 2026 09:40:12 -0800 (PST)
Received: from localhost (p200300f65f044d0890ab5f15b7da13fe.dip0.t-ipconnect.de. [2003:f6:5f04:4d08:90ab:5f15:b7da:13fe])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb88402ce9sm584249525e9.0.2026.11.27.09.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:40:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?utf-8?q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] pwm: tiecap: Use dev_err_probe() for error handling in .probe()
Date: Fri, 27 Nov 2026 18:39:42 +0100
Message-ID:  <275368fc5d2f50ed42b0c344712eb8753f34131a.1795800756.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795800756.git.u.kleine-koenig@baylibre.com>
References: <cover.1795800756.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fanNnHi/RF88/u9VlLCWbekpr5EixXr0JbIpj5nsOes=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrCcBkWjxsxnINFGpBRxMjWRSmhBNhpvtxaaIwg 4ercOjy4G2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawnAZAAKCRCPgPtYfRL+ TtsjB/0Tdr3i4C6xGIWj4FqEbQqyuvgRIPS2zCuNUQkjT9Hwxo4b38gDNpQjy1mBeZSvZf3Om/M XWvAzhHsoAYx60bQOBE1Y44tNkf8qC7MT6CXLqLuX2bKBkmK36Dwbne31v5pNngt66j3Jyp0IyV 63GKhaVscNyROvLzTlCZ//7i8/a1FEGG0qxvgTm7DrJkgsmsbGC4uuYyX/uC9vKSWpjYIMkoaCV ocI8RG7SRjYM/niVKSUQpfK6GPVO7c0YFr+pgJ1SqiLqU61yVh3M/2SE6muBYzq0xF7e1LI+Kzv OmB5Ckk4ZVFputYO7vqZfDRlYtGqFcA0Bb6csxwlioFihf+d
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Usage of dev_err_probe() is more compact, (usually) emits the error code
as symbolic name which simplifies interpreting and also properly handles
ENOMEM and EPROBE_DEFER. So simplify the error paths of the probe
function using that function.

Also introduce a local variable for &pdev->dev which is used a lot in
the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiecap.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index c441df9d3f62..a7665e514865 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -254,42 +254,39 @@ MODULE_DEVICE_TABLE(of, ecap_of_match);
 
 static int ecap_pwm_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct ecap_pwm_chip *pc;
 	struct pwm_chip *chip;
 	struct clk *clk;
 	bool running;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_ecap_pwm_chip(chip);
 
-	clk = devm_clk_get_enabled(&pdev->dev, "fck");
+	clk = devm_clk_get_enabled(dev, "fck");
 	if (IS_ERR(clk)) {
 		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
-			dev_warn(&pdev->dev, "Binding is obsolete.\n");
+			dev_warn(dev, "Binding is obsolete.\n");
 			/*
 			 * An ugliness here is that the resource freeing is
 			 * bound to the PWM's parent device instead of pdev
 			 * itself. Not very relevant for this obsolete binding
 			 * path.
 			 */
-			clk = devm_clk_get_enabled(pdev->dev.parent, "fck");
+			clk = devm_clk_get_enabled(dev->parent, "fck");
 		}
 	}
 
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "failed to get clock\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clock\n");
 
 	pc->clk_rate = clk_get_rate(clk);
-	if (!pc->clk_rate) {
-		dev_err(&pdev->dev, "failed to get clock rate\n");
-		return -EINVAL;
-	}
+	if (!pc->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
 
 	chip->ops = &ecap_pwm_ops;
 
@@ -299,11 +296,11 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
@@ -318,15 +315,14 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		writel(readl(pc->mmio_base + CAP1), pc->mmio_base + CAP3);
 		writel(readl(pc->mmio_base + CAP2), pc->mmio_base + CAP4);
 	} else {
-		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_put_sync(dev);
 	}
 
-	ret = devm_pwmchip_add(&pdev->dev, chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0) {
 		if (running)
-			pm_runtime_put_sync(&pdev->dev);
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
+			pm_runtime_put_sync(dev);
+		return dev_err_probe(dev, ret, "Failed to register PWM\n");
 	}
 
 	return 0;
-- 
2.47.3

