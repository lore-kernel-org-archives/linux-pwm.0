Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346E3BB138
	for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742046; cv=none; b=QtFx2JmxUnXmI7pC5YVUOx61jTHRAYbaASMG2mDw8zSBl9RpdgAof3K1Lxfpg08jeDXsVl0fYSDZP2SDzF8ejqOGpQwhM+o5FQVrJVC4TT6Il5aHEAcO1iBJNZx6CM7ns8jm/J+l8Ttxvi2i0OLoafMtKyKsUjI+Z0BSQTo/h+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742046; c=relaxed/simple;
	bh=2qoRJ0EfVBn79bEPYyMqFcoyr6B/4C2K35zl5VDE3eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVRBpo7E7rYVXUFVwWZ+tGP3ybUSHle3bcr9NmnkiZRFnA0mF4dxAseidChSzdb5mQJxhUnwAsa95P+PPW/UctVTorQ3jps14NIKG2DR92KV4TYRk/hh7OW/NbdHUFysXk67jHi9uYKHWJ9i9/SzKH2Fiky04dfEvjHQwNqMr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J+/snMVG; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J+/snMVG"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so438145f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789742043; x=1790346843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UxDe6gUzn40JCI8qcPtk5k9ALSIeeeIUpuxJOenZVXE=;
        b=J+/snMVGbQps9lwPp/EqjZHmJhuAVhJEuHubYBOguxxDVVB9y6uh94ej3i2eXXVqe4
         8HKF0O0iD4bPrFQYEgohxNwJc5ZeGc03tYRdIHrm/eVq0/yvxsIyvkn60rnjpyaWsRuy
         BqfWmio+Sl7+CmhL+hlxEPGjVl/mlUfN5uZtLni4i2NNwimv1wNSr7OBTzoLqP7QsMLP
         bkvE9jhJ7xF8LPFvv8Z/5gIiKhNKLVXuiJtUNVG1z5gZzJh6B4yP41bzqmESa7F/o24k
         /CnTV1kxWdkL/9WGzuJen7JMIOn+x1ryhfSUwW+2HnShw0XrGE0Z2pFjA4AsfGFVUM+8
         AQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742043; x=1790346843;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxDe6gUzn40JCI8qcPtk5k9ALSIeeeIUpuxJOenZVXE=;
        b=gLflUSyEWn/+boXqeJa12wPt8A5gsRtJcjDuJbX7yAnB94YzWOAwg6ihOwjLtXk1K5
         l25hkQ6duuASYco3eSm8sgExkGGzfWkbPFeE6GxKfbRKnIQ3MicEvCeqyTgBa0itJU/4
         HU3EKJ037aJiHgePu5g5lcNPrtZbbbPIy3WO7mvmAU1Wo/CZuVLCmTzBbYZAKuRXs6OR
         XDzx1mAOyb6RFVJ2Ce4tlzU2Lvc44Dl7a0402KMWh6bSGGEdoMewufO9LveGpjMqObFI
         puVZutweu8RqVoqyBkm+JKdNJjtjsgor8HcVsZU5pwnTRLivdU8Xv01oIt6OgMNHmDXP
         qMqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMZGCaw/ji6HMtfFMgUHM4n24N3sDVG6Rmt1LH7s97OZpG5SSMWqtqICoN6Vbx7l7FV1TJ8QlCF+o=@vger.kernel.org
X-Gm-Message-State: AFuF++kwjVD8k2PYAx70fgZViIBXX1pplYInf7nVB7EnzYojfyAkSntD
	j4ZZa7MJLeRvT0L3samIM8bp1rzJzY9El/LHa3B+xm397nqONQZjVNXFgW6dTi3o7jg=
X-Gm-Gg: AYBFou3hFmKSGdd/l/Us7T9c/aAEUEs567rcoYmJww8D1jxqY3z99DtKlsn7hXTUODZ
	wTRv2D99oORv68OTkI4lVD9KofsUm++bVbM+J1CFj+iD3paHnpfPxPUZ/wiUcxh1fzc0qtL2xYO
	xwgSW77SlwpyC9sowKjRM+pMcLIgStBJIfJ+EQNoxzgz2sUatUR5EW9VPdkilJwi5s30jMBtNU8
	nmRi/HWFfqLGOc2+Ou5DELKhvjpR84l7FZGqU6n4PCSv92CNvWdhrJLaaKKle2eMgxkneH1YS1K
	AVzr6dS6zYuKnaW3pLTjPWgPOQEK8Cw0vRfMDl8Rd+7pEFQWGjmy1VPMiST/qA1j0u3DZlGzumK
	fq/T2u7Wu0RxxEJEpEDOtCTjKyTf1guuU59swr+dqY2pGPTO7/qMT9BSzXDp2MEeZCD9V5X3NvF
	hYFLuCWahXBVZwrs1T0RF+3pVsydc5HJ6s5cbm8m99uwVF0HF9UThn1WzaC3vHyaeLCBLjAkDj3
	rtu0fBgC3L5ErymJTEHpPseAI7bw8emWVPMu6R5dDjujwkG0De49P85QFPt8Q==
X-Received: by 2002:a05:6000:4809:b0:487:b50:1020 with SMTP id ffacd0b85a97d-4871e221a3dmr3786100f8f.24.1789742042764;
        Fri, 18 Sep 2026 07:34:02 -0700 (PDT)
Received: from localhost (p200300f65f19a90444c8989fe13f5be4.dip0.t-ipconnect.de. [2003:f6:5f19:a904:44c8:989f:e13f:5be4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4872008fe3csm4571627f8f.37.2026.09.18.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:34:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Date: Fri, 18 Sep 2026 16:33:46 +0200
Message-ID:  <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2qoRJ0EfVBn79bEPYyMqFcoyr6B/4C2K35zl5VDE3eo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqy13ud63rfP7uDkjurJaYiep5fuKSkqdGpL8LnrWySTd +5827emk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFIAbvZj9nz3Tx8s7cn4K6DbL upx8kSqszOKs2qpYclZON/5DdYAqo2jYHt8FN537v3ovvLGpu+TPmXv2PXeKo26/PpZ34pOiRE/ yjWevH942vJ3i53B2I3u6kjGjZb5iQtGmaa2+v5Jk4jYZyF2KvjLvhNIdNYGiHa0TzRQOM2/ijo 8+YmczdWFBW8Xm76/d1opJ5q7ltG/TP7/zTrt4Tjl/lOCW48LWoQm5ln8PCwm9T3txc+HVK//dG E/J3Gx189d6HS7Oftjos0yJ9ucW+VUCr+MaLv5wz77E26P+exJb47NNUypT3y0S8fyw/aR+HMPb peF35W8s2y21lOl4ef7WdTN+xSfzygo8ZJV0tMgKu5sKAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

It's unlikely but not impossible that of_device_get_match_data() returns
NULL. Handle this case instead of triggering a NULL pointer exception.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tegra.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index efb7ab60f602..b461d3877f43 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -323,6 +323,14 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	int ret;
 
 	soc = of_device_get_match_data(dev);
+	if (!soc) {
+		/*
+		 * This can only happen if pdev was matched via pdev->name
+		 * (which should not happen today) or in combination with a
+		 * driver override.
+		 */
+		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
+	}
 
 	chip = devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
 	if (IS_ERR(chip))
-- 
2.47.3

