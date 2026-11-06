Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981269;
	b=SOHNcRHOHlu83SeUhJejiMGPw0H3nWX8f41YRydVq8sPdAfAPDsmxHPeLj4MJ/fnByTO
	 YWBONbB7w5jAodaTviH+6CvgVJMpCUEixYN4UY4Kx8aC0gddQz/mRaXANqkJGuVkli9Xo
	 skOMBpu9pzVfxhnDizZNgAHa8BKyzC9V/3y+QGv9IIXMGXAjoE3LZvAbKOa2U5xd+ZuGe
	 1QNUakTxHzvifayXv+e3cz9ImIQOXNCHGLdEQ8tCCtqLeR0Bp4otEnR3uebm4zFe1q2jS
	 mtZd5nugl5w7tjWd6+5PBUytH147yssaQ/RvD9TvI8QOoeaQAf2yC/nlWK0xiPO2+fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981269;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=+3nGazd3fxtqrZKDRm9/9owaBnfQNvNHAKAoLZ4kLhw=;
	b=WgYxFqFibVS5ntH2zLT3fSiDyZSx+jPV7uELSaMncmbP6LHjcJ5p5JeJlDkh5/LslRzZ
	 Q+olOtQwS+Gy+B6qESEXj5KbugG6xfoEPORyLXd6+SN4LVQyT5SQ68yMXl9j+6MOdr1RJ
	 6FIbalJXMiWJAgRGxZynLMEFLQgVoCR2siFCAmYASOBUcej7PjBEScN11NGlvMUN9AyXg
	 LhbpP8G4G9n7C1N5sHGHHM0KfSPErKxo5it17ZCfPNemhvhgKaDW8G32azcsH6mUwzvs7
	 wOIZtFjPVaeVXEmZ1XwqK/LvpJl/s0j/kx/Vez+miGtbTilhMdu1Rbfi2vdWsyZz/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E51606A333;
	Fri,  6 Nov 2026 16:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E51606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkbl3NfVz57DCg;
	Sat, 07 Nov 2026 00:07:47 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A6G7WP1074980;
	Sat, 7 Nov 2026 00:07:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:07:35 +0800 (CST)
X-Zmail-TransId: 2afa6aedfb47007-b9f7a
X-Mailer: Zmail v1.0
Message-ID: <202611070007358971CKnkEMJJVl0_NxsRtm--@zte.com.cn>
In-Reply-To: <20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn
Date: Sat, 7 Nov 2026 00:07:35 +0800 (CST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>
Cc: <laurent.pinchart@ideasonboard.com>, <heiko@sntech.de>,
        <ben.dooks@codethink.co.uk>, <benjamin.larsson@genexis.eu>,
        <nuno.sa@analog.com>, <xiaoning.wang@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gcHdtOiByb2NrY2hpcDogRml4IHBjbGsgbGVhayBpbiBnZXRfc3RhdGUgZXJyb3IgcGF0aA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6G7WP1074980
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:07:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFB53.000/4jLkbl3NfVz57DCg

From: Shao Mingyin <shao.mingyin@zte.com.cn>

rockchip_pwm_get_state() enables pc->pclk and then pc->clk.  If
clk_enable(pc->clk) fails the function returns immediately, leaving
pc->pclk enabled.  The clock therefore stays on after a failed readback,
and its enable count grows with every retry; unbinding the driver then
hits "Unpreparing enabled" in the clock core.

Disable pc->pclk on the error path.

Fixes: 11be938ae003 ("pwm: rockchip: Enable clock before calling clk_get_rate()")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 050ca8aad0ca..17cf1e28a3c8 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -76,7 +76,7 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 
 	ret = clk_enable(pc->clk);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	clk_rate = clk_get_rate(pc->clk);
 
@@ -100,6 +100,10 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 	clk_disable(pc->pclk);
 
 	return 0;
+
+err_clk:
+	clk_disable(pc->pclk);
+	return ret;
 }
 
 static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.47.0
