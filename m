Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703468;
	b=otjl1viG2NpYh+8jL9yiApZcQPHzq2df+LhmEyr+gT4YTPzRihvV5KEg9n5CCoegEIcZ
	 aKmgapuMUxX16ZqM4zOfg2PmQuZsloQLLDyrmb7oC7uIKzddguokE9YrtDEkERRhcC7wa
	 UWxVnGmaKBhCB56orZgPxvkvmPnBlkQDSo2SjGcNB9PiXdmsFYN3J+w+vd9SeCaXDcpV2
	 ZHDEB8D4nk250pIDCaDXFzak87gpRvjK8Jn67HsREd93QBPdqvJFeltD39voJaZOd/Odg
	 Hh9Y+UA+V4sZ0JMDz2PUQeRAAwiAHrwHF8jfOuQ1Atvp9jeOwMlW1oLOLzS3mzlk1xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703468;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7cKGcElw+LyKahzEfoUDXXu+nuhjcfc86ohLMOUpCCU=;
	b=xtqJvR7KVuo3oGMUoa6BR6sZlNNwXx2vd+SVkMoUgMsXEINZdNbReRjUBx2n3Gv/385O
	 HFbH7gfN5mlW39B3ivoXe6uVoI63r46HoA2ioJQSHMP64k+uDvbQujkRReRNrtoKb73yy
	 2h3WB8xlJDkvbNPTPVYWMWjpg2UWO++vi1CHtcLNUQt8LRWujJ3+UMoUiCoa8570BVjUl
	 xm58mcaU64UTVb2VobXgD4Ok08W+BBrdgmyn1An98pJGgh2rRX21hk9dldZfAdZaJpFb4
	 DLtw2qTnKRePs5ASsBE3lbttGHCnz2T7IhVEi7YDVMkUh4gi4RyosMIeekMGe/4Ek3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2KxkNk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B845606A6BA;
	Thu, 26 Nov 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2KxkNk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD581F000CA;
	Thu, 26 Nov 2026 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703468;
	bh=7cKGcElw+LyKahzEfoUDXXu+nuhjcfc86ohLMOUpCCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j2KxkNk0xHj89jBGgiHwOiPHo0AqQ6dTWLChX7vOwKi9+zwWm6XE7zoPsxXwC5nAp
	 QK8a8fRlpaPcmkYekmkwINoUd6paRpB/Fl/wPej9Q2yinkEBW1Ib2IBSZFAaTFV7Jg
	 75zAyIVNqFIhQkpbbGH8neG12bqjuOdxyZTz20OlXz3xnuUMVAVVO9vFOJ7368i6a/
	 54k4cq/GfUKeuQC4QZ1DjWekeMMiRmSUVmCfHfT34OgVqLbRYK1whA2dHofudnKxrv
	 V9wRaLa4t82ia6B8Fd3ihIdknmsQhc6ZBatE7VMImw6DjihpvdQd/2Ieggb0VoA4Dk
	 4tNp0woVkPE0A==
From: Geert Uytterhoeven <geert@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/6] pwm: rcar: Use FIELD_PREP() for PWMCR_CC0 access
Date: Thu, 26 Nov 2026 15:30:38 +0100
Message-ID: <5ade99984b1ca21438a1977b65b51795774dc891.1795702568.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795702568.git.geert+renesas@glider.be>
References: <cover.1795702568.git.geert+renesas@glider.be>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the FIELD_PREP() helper instead of open-coding the same operation.
Drop the now unused RCAR_PWMCR_CC0_SHIFT definition, and redefine
RCAR_PWMCR_CC0_SHIFT using GENMASK() while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/pwm/pwm-rcar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1733cd700693713e..4641f258df531baf 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -25,8 +25,7 @@
 #define RCAR_PWM_MAX_CYCLE	1023
 
 #define RCAR_PWMCR		0x00
-#define  RCAR_PWMCR_CC0_MASK	0x000f0000
-#define  RCAR_PWMCR_CC0_SHIFT	16
+#define  RCAR_PWMCR_CC0_MASK	GENMASK(19, 16)
 #define  RCAR_PWMCR_CCMD	BIT(15)
 #define  RCAR_PWMCR_SYNC	BIT(11)
 #define  RCAR_PWMCR_SS0		BIT(4)
@@ -99,7 +98,7 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 
 	div >>= 1;
 
-	value |= div << RCAR_PWMCR_CC0_SHIFT;
+	value |= FIELD_PREP(RCAR_PWMCR_CC0_MASK, div);
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-- 
2.43.0

