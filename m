Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420407;
	b=c424XNOf4MYX64zV5hm/rw9MZ/CE+2fPvuoiZOVufi/4FMlE45wEBDPW3q714f8twp6l
	 HUObaEtsOtHRYpgxO100fqq4gPXTtRJvRGpaFma9j3YnalYUL3FDizFatcS/NRtED1vAl
	 oiXOO+Bq6wCeakyKzE9k9F3Ami2D0rQgG+8VPTUMa5U3ydaUms6wgWK/w5FNJuW6L2urV
	 ck/XA/hfduHEKckuwbh+ve0r9M11/sA0PtP3SoJ9CT4aAVJbjOpODm6GxbHTYGxRRmoQ1
	 rCMoT+3f8R70kQBEjW2Z/eH8ry4pkQeT+CHtXfhA2R9vPpVaHxmFP7BR8YNi1VIFCag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420407;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RAv3jMi9jT0oBAikeI5ITIU2nYz68w41tRGXr1NGYec=;
	b=ekzCxkFDRvZd/UbUBAT7bJoYYIY0llcZc4Oquj8Ekt5DOroXxovG/63d8v43kfJJeWkJ
	 /sUMw4qA8YUQldtGDnq83ZUnpdB4ZBn65zq7P1+5cgd/Zn2L6EavOj1p8OCVkr6bsXKii
	 oRsDZCcFRTfFCJpLxLptO7seBUvCGsgUQ3eg8Gg6o0X7AS+Q3ZJArwBpgw3qFf1grX4Pg
	 YAY3aVog9DZEjFVZzF9nDhSmg1rmwe0GbT5mIR9qkcKdGEOGzuSqnBout3moCPqWJ0lEk
	 ra8kYViI4IZW+pnJzr8E1WCybcXVenvv4JlJi/DNapeCX7NyZ4dkzeooRkGWNiaA+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BApg77rj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F1606A32C;
	Mon, 23 Nov 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BApg77rj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB9D1F000D2;
	Mon, 23 Nov 2026 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420406;
	bh=RAv3jMi9jT0oBAikeI5ITIU2nYz68w41tRGXr1NGYec=;
	h=From:To:Cc:Subject:Date;
	b=BApg77rjizqtZBFefEroVa86MCmngRCuVmJZ9a1RIhjk4tw87FnxhegKaB9bg4PRi
	 y5pC2o0zJCrk7JHOD7k2lCHQAcIeIABa7vzKx8c0qqBIi/TzRMVfdqQOWwuU0hiCxp
	 gOLzGRjHEgE2WLqYv8LbkDokeQzSq36fmL17QKaZtVQ/QZofxDP2DyFiWgYO9ZJEZW
	 2POq2kOgtdh3g5gdfjQzbYMUKnrkngxCTh3C7PWcAEis9Ur47GXK9cZPcyBMz2JO7y
	 CwU73mjYHzQxeb5tmHk0o7pfW8yWz+9JbCFPKuiAOteWrlX5hKT/Je1/WAr4kNKQ4K
	 +icRjXbxKu3qw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Grant Erickson <marathon96@gmail.com>,
	imx@lists.linux.dev,
	Joachim Eastwood <manabian@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Lokesh Vutla <lokeshvutla@ti.com>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	NeilBrown <neil@brown.name>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Philip, Avinash" <avinashphilip@ti.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sai Masarapu <Sai.Masarapu@imgtec.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	shenwei.wang@nxp.com,
	Thierry Reding <thierry.reding@gmail.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>,
	Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 0/5] pwm: Fix various bugs reported by Sashiko
Date: Mon, 23 Nov 2026 07:52:50 +0000
Message-ID: <20261123075320.379664-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
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
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

v1 => v2:
 - Drop tegra (superseded by 9ad5602d4943) and loongson / axi-pwmgen
   (already applied)
 - mxs: Check pwm->state.enabled directly instead of calling the
   consumer helper pwm_is_enabled() (Uwe)
 - fsl-ftm: Move ipg_clk enablement after the channel loop and document
   why it is needed around regcache_sync() (Uwe)
 - omap-dmtimer: Propagate negative get_pwm_status() error codes out of
   pwm_omap_dmtimer_apply() (Uwe)
 - tiehrpwm: Clarify runtime PM state before pm_runtime_enable() in the
   commit description and match teardown ordering in ehrpwm_pwm_remove()
   (Uwe)
 - img: Clear autosuspend in img_pwm_remove() and document why driver
   data remains valid for runtime PM callbacks after pwmchip_remove()
   (Uwe)

v1: https://lore.kernel.org/all/20261105143847.2559586-1-lee@kernel.org/

Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Grant Erickson <marathon96@gmail.com>
Cc: imx@lists.linux.dev
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Naidu Tellapati <naidu.tellapati@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: NeilBrown <neil@brown.name>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: "Philip, Avinash" <avinashphilip@ti.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sai Masarapu <Sai.Masarapu@imgtec.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: shenwei.wang@nxp.com
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe Kleine-König <ukleinek@kernel.org>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>

Lee Jones (5):
  pwm: mxs: Return early when disabling and fix error-path clock leak
  pwm: fsl-ftm: Enable ipg_clk around regcache_sync() during resume
  pwm: omap-dmtimer: Propagate get_pwm_status() errors in apply()
  pwm: tiehrpwm: Enable runtime PM before registering PWM chip
  pwm: img: Unregister PWM chip before disabling runtime PM and clocks

 drivers/pwm/pwm-fsl-ftm.c      | 12 ++++++++
 drivers/pwm/pwm-img.c          |  9 +++---
 drivers/pwm/pwm-mxs.c          | 34 +++++++++++----------
 drivers/pwm/pwm-omap-dmtimer.c | 54 +++++++++++++++++++++++++---------
 drivers/pwm/pwm-tiehrpwm.c     | 19 ++++++------
 5 files changed, 86 insertions(+), 42 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

