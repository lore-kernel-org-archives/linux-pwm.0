Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801211;
	b=ZDTRMQwIAArU83VAcdrkUxFVI82lHrumXq9AlxWfa+e3DJBa8evoF+KX+T2EoO26jv0f
	 DP9PTBkKYSYkwAFBxNC6lc8TxxrbZJWN7StUNefRSey+CILBgtB+BFBstJpjnKqfMD4D2
	 WQ6gx+4moUYXeuPCrQn5wBk1qZ77kTLInMmMe7yjl+uH2fPWCQqqy+Uz8vd43g1Y7intD
	 30vN4rzLLPW0ztFDi4AuNY62CBU7MlkEbUXq2gBSVO0W7C2RSvVgzQArKg2l8YVywpUwz
	 MF7xVqM8QvTyiXBYPVf4TlMZabUYgR3cqiuFcF4WaEvI5KsKjPdXEjElwkfimwIQlew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=ofArx5ujhLyTHENIAOuRlAWqZZezV0c1Av4Ix9tXe4g=;
	b=wNcsx4XOd4zIUuWgJOPIVcSRCuc1ORUmOWV6I2FSbhF8/p8AsgXHa+ltuL73dWmG/zpL
	 oJyj36wIXz5ukIMyraOufLUAX9uAZZxSKbEsDDGR2UK7kzznklq7zLEHDe8sTcNjs7wl9
	 5VQmM9Axh5+Qxcf+xufYcMRGVCgULo3a5/4eAnRy0QuTed1KpzW7qQQ5YiHZj9gULvqEh
	 mp/HZD0bN0C7d5OtfHCdoNzmaYQg+sYcil6K2jF/Qu03EihvRHUMGp15l/1b392ZWBQ88
	 nJ66pXMglzB0DuVn7Ii0R5xiXBEXT9sozAdk9mX/hy5tEYXQg/p8sGh+R0D8whpB9vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QzXkkxb4;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE9606A31E
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32CE9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QzXkkxb4
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso5305243f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795801209; x=1796406009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ofArx5ujhLyTHENIAOuRlAWqZZezV0c1Av4Ix9tXe4g=;
        b=QzXkkxb43v6gQ2CTzV8YMdag74CWJ5+ozyMzEeC5wrFjCdKQlX6dC7Wyu3YOyzEPjS
         AXrxY9I8SDswiWYkplCebkVAiWAUYzLzOUOsn7ggfb8MU8iCDgMtyU0fn0gEHybmhC5V
         xe2Z8LnEs25LSgzPrkZO6rjm7hxnVGKtz46ZgT8ulM5K47279oOE54XDO10f4OZhhleu
         iw0Qh7aajtUvThR1dl/ihiScQKZVdU773LB4i8SkJpXxwmmvt85Cq6sV+ZMXdQ45MeEz
         cyFLS2N3TpbshX23Sa9h6qXMbq2180/+XPLo+2vKp2SZdaELFvmNpcKNvNvkltAiU/KM
         o1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801209; x=1796406009;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofArx5ujhLyTHENIAOuRlAWqZZezV0c1Av4Ix9tXe4g=;
        b=W1ExlJn4nfV2ng7G19BGyIk8ibb+A6A27+PS9B1L6IuOXJR1T04q/qsZF3rh4zfQV8
         19g+JCQCHHVFY38pCNoRIjwxg0T7lTW0HGa1tuWcuUlJOgdRuODLxBwKivH8z94JecPI
         4S4BRCGTnb6uCWbnPKHLewmaS8OoSeUMQUC6DgbazXNRlKSPSfVWHdB9ojqTAfl//szc
         Ratx9iFW3DTnQPXvkj3zAjzR0IwUSJURpe8Grl6y8MH377MQIsehcRbk8ofn9xlYkIly
         g0yODVG5jVOI2qNkEe1DbBrLKLbEsOiHcngHVxy2BeWSE0ZndwFASTfd2DS5XEPowQkk
         woAQ==
X-Gm-Message-State: APuU4Z/7Zt2zTZFKEuK3Y2gHHWPBDP1rx3o3z1KzW91rGqJiJRcM8Dmg
	5q3CIvWPckmSC5Vxm2vw0OrwqT2peauOuNkTcR4G2AWu368toze/UGgq/8aBOC7I2J2Zo4XEIGR
	dDA/rFJE=
X-Gm-Gg: AZFdTZcVce7VWQb6xwurt6HSsW41kM8eup8splq7qKoOkIPI4ddUBKC0STWctQzhJf3
	JpTIq7eP9nGMjzylCPX+XWgVdJpAmsB6VrHSpFhsXums1orvjKsfHrSlQLMzSp8X5VIQl6aVjV7
	qSkLBjeG5AOqYQlGcA4TIXluWFiqbtKbcNaO+C5n/gFphvYglMeXZhBQAqpVuSzDonXcTyR/OkW
	eRAcvZipjmu9w914rLraJVqYdMvy0g4SoWpKPhYKW40Kew0dHnipelgLHebTe5CY8XA9krc7PFF
	Yu9n6Pra3X63lFr06JoguO9gUGdcEcFGlOaevr+nO8d4vGcN9DEcufYx/wiXnXwDp8U9we+7q60
	OHwBY0LkQRo7XYJixmko8BKXIKePnzW4cC8OadTtxvLmU0L9T8MgSSAnI3LcLUbgraASlvm9y1D
	BlyA7uV4E3GBfeJARg6eu874hng2l43sV/xnIu9AxMR8JjFPI6OaIAb20yQQdpgyKEv+cXhMVZ4
	POsPGWIrFGSBfTUqKlVDqI4Hxgvx0i/1nEXHPg+ceXn6y8RN0zDuvyZNrZk6Lhm6Aqr05LLAdeD
	GB2mcEwbYdMpCtaSAmivUzfDvXRJ8WbKDnFU4O3Z23uGtGxAimxtBvHH812xUIf9eKeNUjYNWIT
	V1RIxzLSIicTx29TI
X-Received: by 2002:a05:6000:220c:b0:49a:9499:7909 with SMTP id ffacd0b85a97d-4abb560e39amr50243242f8f.35.1795801209594;
        Fri, 27 Nov 2026 09:40:09 -0800 (PST)
Received: from localhost (p200300f65f044d0890ab5f15b7da13fe.dip0.t-ipconnect.de. [2003:f6:5f04:4d08:90ab:5f15:b7da:13fe])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6baa397asm48965065f8f.48.2026.11.27.09.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:40:09 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?utf-8?q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] pwm: tiecap: Fix type of variable holding clock rate
Date: Fri, 27 Nov 2026 18:39:40 +0100
Message-ID:  <2d23fd2163a63f0d9a4b4a4894c0e179ac777aed.1795800756.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4Ctacgtifo8C3GPHQiX3Wd3miPIQZmI8GaVpnJ0UTIg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrCcBdNY/FpkIDaVueb0nkyYPqwc6huZFYVFOem P6YdtVUZa+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawnAXQAKCRCPgPtYfRL+ TpP2B/9EA6FBVWBX4jcIKtLfzJFsUe/XWi7tq7uXA3T77dq5Ugu47CLkjZTtjj7n+Rws4EVQ1Zf Z38qagwt+4Euq0HAewMLgk7DPstStG/8ITmRA8qL1h015geX31k9GzrG/oL66bEGOm9xhMq5gZI f3BxI7YKdf6qynDklF7gkUaadvSOyDZ/z8Ks2lEK+/jFAv6jiGjbC/FIARQ86e7q6w/1yDlZ1ZM Xcr7RXYlXdg3dVbfm97tnEu7vMDfE4ynfH/rZL02UXRWOlIafYRPOS7pBhg6JgOX3lxHqhLJMSF zgjEKa5myiFsT/6S2PeIxAjr//rtz9xZQUWTsWHDYAg+eRDm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

clk_get_rate() returns an unsigned long. Make clk_rate the same type
to fix silent discarding of relevant bits for architectures where
sizeof(long) > sizeof(int).

To let .get_state() handle that possibly bigger variable use
DIV64_U64_ROUND_UP() instead of DIV_ROUND_UP_ULL() as the latter assumes
the divisor to be a u32.

Fixes: 8e0cb05b3b75 ("pwm: pwm-tiecap: PWM driver support for ECAP APWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiecap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 9a490b8d60ec..7ca23a7576bf 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -37,7 +37,7 @@ struct ecap_context {
 };
 
 struct ecap_pwm_chip {
-	unsigned int clk_rate;
+	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	struct ecap_context ctx;
 };
@@ -232,10 +232,10 @@ static int ecap_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->polarity = value & ECCTL2_APWM_POL_LOW ? PWM_POLARITY_INVERSED :
 							PWM_POLARITY_NORMAL;
-	state->period = DIV_ROUND_UP_ULL((u64)period_cycles * NSEC_PER_SEC,
-					 pc->clk_rate);
-	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_cycles * NSEC_PER_SEC,
-					     pc->clk_rate);
+	state->period = DIV64_U64_ROUND_UP((u64)period_cycles * NSEC_PER_SEC,
+					   pc->clk_rate);
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty_cycles * NSEC_PER_SEC,
+					       pc->clk_rate);
 
 	return 0;
 }
-- 
2.47.3

