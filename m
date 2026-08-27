Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5643C05E
	for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828266; cv=none; b=cwMssG1Qy9PyeLhkFYNbdcKOggB1FM9OyJXtZOqtIaopHAZ0/w0DgMimW+Ci8vS8AcHwJ8Sw0yfDqH34NIEYVY70zx9AW3lEIWrJ8s6pliARWOZKwtBNOM67T0bpLveGs6R+sXaUee4ewf+wq+2cbhns6XkqDFnmYXAEhJRTySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828266; c=relaxed/simple;
	bh=ZZqfBGCZfSe4hR0/zIUzrYcpc4DmFc9ey6Ju3c4LDuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQI2Pxfl6dQOHQHbhtvDXyHNxZ+eWG0IZEZLHltpXqNf7UG5+rYSedBqdEVGtWir0x/hLewyYGMWWAoya7x/6B2BxYD4UiMsBVDTs3mRhHY2UR/5zOVYurEa9l6Pd6REuUzV6H+hsISwhQ+U1tY45Ycr7ttd+JUCQRK+ewPVLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RbJqce52; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbJqce52"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1821737a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2026 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787828265; x=1788433065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ntmVipoSayOwXs57Kc1THh0tKdh0WN7s/EHA02RtOpA=;
        b=RbJqce52Hdp8RQ7BGkrDX7TqTGwQZ8PHZvbYP6vaQ00Jf9IatpJ3bbQYMo6r10J7Ay
         PsAqgWwsCKlYCA2CGNWfyqOEKLCNnlgndbTi+hYa0KeTSNKcOT6uuRzqa3YvuRby6cY6
         uHEfFVt8ap8CoOWlIRBPyAAxr6Ccx8+RepizU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828265; x=1788433065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ntmVipoSayOwXs57Kc1THh0tKdh0WN7s/EHA02RtOpA=;
        b=sDtRP/kCKg2ItdSoZyrGD1OtLwN86JiG0clG50DganmfBWdqgQ2m4lTR2QdaMYBwN6
         yfMQsdzLnmyelNCDflUgxwVVsZFbXWcIjBfstS4PBu5Wnjtyc8yv9vK0hXHnZHVkR5Ed
         TAI/r9VTY1MQn1K7RfmWVvhKiNd8zsf63mONflu/yk8thKJZJeQLyOLvW8AuliCQTB4i
         KpGpd83Js2oF/TDsHexAUthlnjz1DJWkmr8AY/sgx3TJYqwyWNwh8pHo3Vv65mw3R4hh
         r91Uky+b9WI7QJb/nJZRnW1ztx0NPfIjMkbQOk3tPj4AqWAxgcDveRgor9a/mGAkzqwZ
         L7iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1i3uO5rrAvGyo1kCIwgDqOuRIChrb/ODmHJ7nYnUblaI58fRUylODW30emf8BaQPeZKVglc/6vfA=@vger.kernel.org
X-Gm-Message-State: AFuF++kY4bKQMu9U5Gi6AfufXoYLc8YakeK0OhcY6QzMnE4RD7mzJSDj
	e+YegWFPFhwaOEhisViQY0mYT3THuSZXpAKfND4c0UPWLYER/FzJ6JGkR3YaSTiEDQ==
X-Gm-Gg: AR+sD12fjIOPuxllAn14r2u4ox6eL0Ob5+U1h3po3tF3cgRr5p4Daqo/5LlktNL+NLg
	ygMEpn1DppEWl3gHGaT4knyX1oYh+uWaWkfpXuqeziGXdHUe2gfj5Ihc1CADVF0o40ReK1BAXso
	cBOOwalaSCs/XaYhbIC/jVQ6lvFM0gRKZHr0AA++x/TasaGPfSBRSQbKmEznd9IX6leY9wK2SbK
	jTYwNLIAzN1bd7WVQxOhML/4U6aWqvHNGFHW+vo2M6g0AfzLwPrh2hlbL+Tk15i8b8D9ZzGdWXV
	38LfQiJk9wHleonS4h7c71KRep6pwOUs7PJFFvEUre3/XPics4stnHv5J2c4LsdEsIb/bIl4QqR
	xDl9l88PIC5bvtyjP8EF02CiBGLD2bnyB0DSGlAIodHYafGqSCV3CREMriGsDQ/3lKAMvxoMj1W
	wKFXXiwknSfDFa6U7uve4FTxdqtE+S9vwqMwDD/nR7tIHCoBgoGT1RW2oAumZakoljwanuaCmF8
	KdXLvHu9oMk254rz8ECB78usHSPrdL5B8ASmNRM+pugh8GTen5ICwuxuQ==
X-Received: by 2002:a17:90b:3fc4:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-3966d443146mr29645548a91.12.1787828264658;
        Thu, 27 Aug 2026 03:57:44 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:b7d8:fa42:587e:234d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186807bsm2434123a91.12.2026.08.27.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:57:43 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pwm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] pwm: mtk-disp: Fix period readback
Date: Thu, 27 Aug 2026 18:57:36 +0800
Message-ID: <20260827105738.8570-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The period value stored in the register is the number of clock cycles - 1.

Account for the offset when calculating the period in nanoseconds. This
fixes the discrepancy reported by the pwm core when CONFIG_PWM_DEBUG=1:

    mediatek-disp-pwm 1100e000.pwm: .apply is not idempotent
    	(ena=1 pol=0 281500/499875) -> (ena=1 pol=0 281500/499750)

Calculation discrepancy in the driver was found by AI run by a colleague
while debugging another PWM related issue. Check against SoC datasheet
and fix done by the author.

Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
Cc: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pwm/pwm-mtk-disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index b5409e15dac8..68a4512e821a 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -212,7 +212,7 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 	 * period has 12 bits, clk_div 11 and NSEC_PER_SEC has 30,
 	 * so period * (clk_div + 1) * NSEC_PER_SEC doesn't overflow.
 	 */
-	state->period = DIV64_U64_ROUND_UP(period * (clk_div + 1) * NSEC_PER_SEC, rate);
+	state->period = DIV64_U64_ROUND_UP((period + 1) * (clk_div + 1) * NSEC_PER_SEC, rate);
 	high_width = FIELD_GET(PWM_HIGH_WIDTH_MASK, con1);
 	state->duty_cycle = DIV64_U64_ROUND_UP(high_width * (clk_div + 1) * NSEC_PER_SEC,
 					       rate);
-- 
2.55.0.887.g758fc8c411-goog

