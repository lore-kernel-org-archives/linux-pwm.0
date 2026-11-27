Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801215;
	b=pEVu2ez43kCcBFX4gq/bmc9XPOVRwnIt0QvS6n+WQPwnjJC36cIo11ZBLLcqMFIyEWAv
	 h/QJtJQ4+XIl0zq18P8/M271vRQZW7yDpqRLy8bRHMIdQCDw6isrRRtvcQdi83BeJb0FY
	 1pvaf9IAOxQsWl9tbVzdM6SYBu/6tJ7/txR/HJ4Dzc7A4S2ZKn2hz9kOAPc9BS+le7odi
	 KIPLk3rVJcwLaTG8bp7cOfj8QsGWi6DGRHI6yQmPnYwIp9j2cYlGZCB7CtqABfnLcj9Ry
	 hhi8okv+QUV7KtMO74gZwi8nATH94CT09GXfy6tmonNotz1lh3m33+Bgk1jBqITakpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=rvkQhnQ3gDZexPEzpwSApUMeXfCt1mDiFOxJe9Lt4zA=;
	b=wlkmzohVS46fAUEWnk2ZKWdo7xnxwZeHmGApIhHy8kP6Yz5lfFg1aM7s9pj+LAazxIFX
	 h1hBuV9ynEnnN+bx1XDB6f86XXD8V4uhyh0tlU6NN3gpOU/DxnG7zw0BqOPu+ER7A5c+k
	 tUFkyXyNdNq0B1n4Tcm1VDf4Tny3CDc2rASoQ9oUxgEodiqeZvI9rsM0tsusfNLYwRX+f
	 1A30UWHG0kuTBVOcRE6AXgN1Ry0ZIMyh0eFV6oEdLQAfMce0c00FVnZK7lDRxLXNxqJtX
	 Gc8NXVPcO8PNPzhgLPw0kRvg1fbEi8dEohWtF3arRq1svg1GKFQoDIEIG2MTS1cI//g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dR43ZBCU;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA410606A339
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 17:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA410606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dR43ZBCU
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so4962929f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795801213; x=1796406013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rvkQhnQ3gDZexPEzpwSApUMeXfCt1mDiFOxJe9Lt4zA=;
        b=dR43ZBCUwCdHsdokV2dvXBDNIpU3K+Qdanl3cD1SiAo1b4KBCISjdNQIBl1NCmirRP
         vUEwJqx45Tg8cTEKRJG4a2BPQZM9zpm/zM3JbYH4JNdm5wQHTzhDrJwobBJNaq99vy6j
         eqATIvpihOUgJxwIXqFXKMCvQInHW7HTAxC8tQlJSpIgkP7TdgYkR2L5eywpkPQt6LRi
         D4L/1Fp810Nq1TzkJ4svmSKioeysYilRVwqtgxc3I/vmYqZxFHgzOxfVGjO3xV2oUZIo
         MHEukY9W73wwv+MRUeZ2VStWk4wC0q6Lq8XYEdBo/NOXxOsSdSSFwylmJxvAMSIlAhRR
         gw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801213; x=1796406013;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvkQhnQ3gDZexPEzpwSApUMeXfCt1mDiFOxJe9Lt4zA=;
        b=T6xtc/jZWRigZz+uykEaofp9WWYrtK4AeCdRSlGinP6N1zHqg4xi26ORUxQZF3/bRg
         408BmZ9gnH6mPYheiWAd9qeKDgUSnyOkXk6mrdsV0wad1+sSEcB96FwC/jWZA7nwuAtr
         aqHk9hqRqcc4Y1bRnN+8AdW9b+OdSDo29/pO1gOhLw90Fecz01mIw+CUC41F7XKbHOQA
         Up4uslh4iBV3yPjZWqVRg/Oe3DpR88mg4trR8SaD6DYiucAr3QscksnVwe1EBBquPYya
         5LxrlDXeuCnllnsoxrXe7nVgCr8agHfaRKh7nvMHrfKm4+4h4n6LiX14PmWdpazZ1K2x
         WS7w==
X-Gm-Message-State: APuU4Z/yK+nOt298pVF7ODTqswGRNLVKbfjPfb8o2fFNt9T4G521Rugx
	jt6YWka5kPJV85AH4XbM3xd5qCifA9fsnziQFoAZvBIPlRIHPayt6lQeSs1gSF1exXlTL4Ms9Ir
	ND+EWwvM=
X-Gm-Gg: AZFdTZfp8DNWOXHwmVeJNPdDvP4YsgxQQ15m0/7XFoLmC8ZXLFr/c//WVHZRD21DF6Z
	B2kktt52zwHswj/4tkhdIPOuijt6Vd2Mcu1BuizG1Y6ooVMBRjF7EIq509q7i+b0+n5Iq7FKlkQ
	J9i0EhD+d2Gqwgxtib7gxH742Xgz9UkfLio4bgExCiDYwaE1QOm6T3IDzwGJMYRxFAhvEFy0LT9
	zJRcEp53Y1Cj2MjMI5ng8TDW9a8j0CWRCeCdi0e0nhcFxCTo809670Zrb58gqbwHP6S0Hm1Z444
	lrBwM/SSa3N/4Ctu2IaQBC3rxDHdWNFvaVVj0IKaIvYFFwgJqosTFp6qFJfgVoasdGuj00aP3gr
	9g0x42BHttjWLXcmUEvA/CrKyZcNdZD16nlRipGY0gQS8SuB+G/e2q3CdEvedF+aUYcHV82JiKm
	hVIm6wrwUyaZoRWPMyqqiQHU0JmoHMaYla71mfaIvUYvOmA93y7A9QDG130BJOioUH5slPSXIT6
	tcuf4r4dXm/leaL8gk9KB/iPs48Uuhjpp3MiGg3wkjWLcpApqhCb6l1DLMSyAIC1miFkiShB9K/
	97diABrnF5SysvMKyBsKITu0AIzc4kPYHTMZy7qWTHQP89nUhu4GHEaL/mHJhDwzASmgtazLB32
	Km1UGf2raPV+PawFs
X-Received: by 2002:a05:6000:2c05:b0:4a7:ed95:7c9f with SMTP id ffacd0b85a97d-4abb19c16a4mr50384565f8f.22.1795801213192;
        Fri, 27 Nov 2026 09:40:13 -0800 (PST)
Received: from localhost (p200300f65f044d0890ab5f15b7da13fe.dip0.t-ipconnect.de. [2003:f6:5f04:4d08:90ab:5f15:b7da:13fe])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6b110d56sm47817846f8f.40.2026.11.27.09.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:40:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?utf-8?q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] pwm: tiecap: Make sure the input clock doesn't change rate
Date: Fri, 27 Nov 2026 18:39:43 +0100
Message-ID:  <cf0bb39e659fb506eaa3eee346338381e4d3618b.1795800756.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=b/a6uxnrk6pYA+orPJD4C66GD24gVjrMfjZs18xuNkU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrCcBmiacGSqh2LVENmfXyBBELOe4Ir4vjkWYKx 1k2boxCVImJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawnAZgAKCRCPgPtYfRL+ TuN1B/4t1FExgceYFxoXrNKnByvqgKqgC2EeizTU1BLPPaF6sazFuOOR4kc0smMTj0WyXOo3edC +Etqli2BMt4PWG7FQakiZRiieCQbE4MxENLDWNKPgZFrvp6u9qktrERAA5GJ1ZeDA70KD3BWW+G Lj3725+y8Hu6TQEo53uw6uniEpXgOBr7N/qhifl2OEv8RQQfN4xM41MsS5gHkdI6H8iefxVvu7H hmtg0fkWJQrTbnsJ79x3CisOk3SJhA2wY37EATUVttYfXHaDy9IfVAKWYe4ZA3RPRJ/ZXsuTMVE onIgoTbvrQ8xPho2GLH4DYEjoSGjevJNcPIgjL3aBAmg8fg6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Correct operation of the PWM depends on the input clock not changing its
rate. To ensure this doesn't happen, lock the rate using the devm
variant of clk_rate_exclusive_get().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiecap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index a7665e514865..05c38967504a 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -284,6 +284,10 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clock\n");
 
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to lock clock rate\n");
+
 	pc->clk_rate = clk_get_rate(clk);
 	if (!pc->clk_rate)
 		return dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
-- 
2.47.3

