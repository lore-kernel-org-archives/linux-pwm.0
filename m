Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801212;
	b=2SDO1GpkdAmtkOZ17gl8+NqkpF1fTd5KbODWSBXhqhn8vvVEOJgUQ4SLSOqNBDgOJKhR
	 OhWwKokZpwnj/IuGPSbTTzLSiVYwiq4nLgdigu0bYFTgSsl+A5r0Qv8imLm3X5dBq5zgR
	 noF19njzzYBr5Y2dY+9g436nPl7Exp2ZPpi6xj8jxk5TpVHPN4vwazRI4wV8/aMXmfSGt
	 QA5rHq7tnvUd8WPlK5msm5vhgmfj24/BjHN+j7a5MwvOgVuzQ021AtEIUfa/xHFjkgRRr
	 1eTJipvJaGffzhndgor/B/BJbzgGKNb8xD5wljqA43ZqI5G9lCnUkG3ilpnVK14khuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=wGqpN1iZZLpNmp84bJRXyOLdJMWq7i5VMPEg1kPwJ7Q=;
	b=E9cdndv0EKZUWAqEwKYDRm3vwaTK+m4jiFAPI+1yI7W6c1Ob2QYpZY0rMKNedZh0A2Ax
	 X8koM5QySMnp89124V4/u4zwP74GY8kklMtO45pBE6hYy77LgcXDbLayQeJHc1gdIe6Ce
	 dFmeZL6fAtwRTuz5lxPc+sja9/1b/+3l6kLb+t3sRXBGW/9RcIxlIP8/u+izNfqK8JJpz
	 Ddpp0hvIYqq4QR15NJVTg8Mjbfz85SNPIHJo3o1+95x1dXHbssK9oCqINSdMxxvJfkOVv
	 2/PF2+9S4jEjh5DVMGwpxEYjfLnosUfFuEVyzz5Za3YDxPKWpuQd8oi+LwO2h+9Ndpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DJgAf3Eu;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB7606A32C
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 17:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DB7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DJgAf3Eu
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso81612735e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795801211; x=1796406011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wGqpN1iZZLpNmp84bJRXyOLdJMWq7i5VMPEg1kPwJ7Q=;
        b=DJgAf3EuwaMP289NzdDFnXDv4/0lPwCnBIilOOT2O33qb2+zJEdEROO2cYY8gWRge4
         lB78ml73kPXJdME87HQCxu/XbnsXP7C6EyG9KlIGJr6MUCthhJCfOCRP6mBKlZcrxic3
         j3JIrZ+urgy2P3K8qhNiQgLLEybWXM6atXN1GTakZ8FaR0CxOcVeQbuLYu+v55jhvC/m
         CWsueeOWBNvDPmhs7T+ioe723jGfhCPdKHMpbILNCT9cZiAeQxtYc3BD1RAQY1d0XLkF
         lP4zoVWdQM3MFQ1Qxi+ptYKharxicJNQKEKz0RB+7BM0B/SxwNA5Ipt5GH7HyQWiSagw
         InOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801211; x=1796406011;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGqpN1iZZLpNmp84bJRXyOLdJMWq7i5VMPEg1kPwJ7Q=;
        b=p/585XoiMTTPdLfVZO2w5CeQaDUybrZxtTdrlSI6uUYS8Wteka1lEimEI633YKl8Ri
         OL5CcdjjOrcg3zvPr7Z6HuhDv/rQpBUZIt9SWkWPx1FtDxH1Jll/jYZxeJhET78lu/cn
         zRkv/rOSOBKiRiZrrQ9/uNjNj3/BCCYhP1m8HtPwqCooXq/faOhzjaQLh3g7WKw6uqL6
         cRlNRT1qxoq+pdaFEQ3EDhhu4pREd4DybtbrjqfIXXznlGrWaxqjiH6g6BYDrTIlebk7
         jzEjbMeJ2FUAQ0zGC8UwuT+czaoJiwFRhqoRT/xkYxCcuYpmRLipkjrhdqQn+MOmOWag
         DxKA==
X-Gm-Message-State: APuU4Z8pmK3k3FHRuewKJ4yD4efnNFaHJiXgRfwi5KBB7K+BOijtHATO
	y5tsh+kShSmUKjw7pkBiaTcpoWAWSLliPuAeS22sB4sPfHnzek92lNjaltZF3buDXsUo+l9Zvap
	upB53Tcg=
X-Gm-Gg: AZFdTZcBufxXb8fmTspyaVGhAe7abDzI0Rd7AlX+nFkVC2hjCbAusiODA6EtIEfggeV
	NY2trgHK07sCLaaAzuyUkl4cGMnTxppPS+kn+QuaX3yghY0Spu7Qt2nGJYxdOQvF3rep7R9vwJ5
	sus6MJAmlcOF3gm0/XiJhjajboV5pRs2oplLTap8hgXEAizs9xVwrQmdWYZs1FiUSyNG8F+cNAy
	RqHuPqS0fx+DfK6YaPNCnvDeYT2kVgqPiN79S1AMB1qxDydclrxqZP7o7zhX5y4tRw2pCCralQ8
	LbPqW7y0/H4b1w6mB7WY0OYcj53UMVQDDmrK7on+7FMhY0+Ox047/OZBnET2BMquEl3G0Qp+Kw6
	CLajIMgb5plIy8gJjvvR5Wmmo9GHQJLzR1ogOWZDisW4d/ZQNGvGZsp3Cige+hKjn8hVSqWEfVE
	kCKh8m7S65zjKnLRpUtR3PHc9dNhFvgK358pFt3tfsd9kT/hcJwR24NhkF0UanOyAuFTHG7q18b
	DT6nEGGVMckm/s4uFkOZJxHL/cyo5Q4NJeNbV/+MJkXIBGYzIrHO7YkZJrfWKz4piJ1jftdKE3I
	QpMhPB40XFWCc4No8etD0+TuTugJDpPkWknsTOR39WNINO9Wh21xRXIES12Rrd+HNtWmkct347Z
	Gd0ZdJGNouQOHyyfh
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr507662915e9.1.1795801210855;
        Fri, 27 Nov 2026 09:40:10 -0800 (PST)
Received: from localhost (p200300f65f044d0890ab5f15b7da13fe.dip0.t-ipconnect.de. [2003:f6:5f04:4d08:90ab:5f15:b7da:13fe])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb906640a2sm408972145e9.0.2026.11.27.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:40:10 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?utf-8?q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] pwm: tiecap: Ensure the input clock is enabled
Date: Fri, 27 Nov 2026 18:39:41 +0100
Message-ID:  <97197e923b47ac6d50f5923e8cf1cdc5cf5f331e.1795800756.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xYtiejv9pUqwFdIS9LUCXqv1gFj6bmlOElRjDsPG1JI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrCcBiqjQD8V+Rt1l6DdsYFd4W7+4kGpJUMlxA+ xDkJG8TOniJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawnAYgAKCRCPgPtYfRL+ ToYtB/kBAexUj8K/c3Y63X0v16R1qWxUocIjcioSjgL5Qa0Y95rXzHUztmyOicuXY04MFJS/fIW bnyD6AaX02ft4gcs4oyezHCTGg4oHOXJ3udNWTtad+A9nujDKPPd02cS8Ybfic6ySBmkxs1uVhY HrKPjf6/ODu0GsaPQhM2TqowvaA3lT/TNPZBlpvkrCbsb4zgE919t0mg4YMpQDGH68VKw0VEpAJ AP8mOAcJWGATkdiWbqgvevA++7I0pQFGkgIHm+rtZZHhXionXXlKgXTpfnb/GkuSChzgsb/7Zrz D7Zju159LYngzDYgQuN5VSoGHtEUh1kZLpbe988m4dnprXra
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Calling clk_get_rate() on a clock without ensuring it's enabled is
wrong.  So make sure the clock is enabled by using
devm_clk_get_enabled() instead of devm_clk_get().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiecap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 7ca23a7576bf..c441df9d3f62 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -266,11 +266,17 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	pc = to_ecap_pwm_chip(chip);
 
-	clk = devm_clk_get(&pdev->dev, "fck");
+	clk = devm_clk_get_enabled(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
 		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
 			dev_warn(&pdev->dev, "Binding is obsolete.\n");
-			clk = devm_clk_get(pdev->dev.parent, "fck");
+			/*
+			 * An ugliness here is that the resource freeing is
+			 * bound to the PWM's parent device instead of pdev
+			 * itself. Not very relevant for this obsolete binding
+			 * path.
+			 */
+			clk = devm_clk_get_enabled(pdev->dev.parent, "fck");
 		}
 	}
 
-- 
2.47.3

