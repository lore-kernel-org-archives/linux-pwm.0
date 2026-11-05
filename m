Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889537;
	b=wZmxoz3n5GgrBnp3f3xFCqYdHxmkTWxbVg59P3BN1Vm4OlFnjeVnP5bU5SuN61EXZSYc
	 ECozuhcJDKYQ7Bh8Ons3d+1ATD9AVzxXK8UJEFbMZNz0XpnuZRuAaxYw6BP/G2rfby4W/
	 QDKiuohlK/W24cluuukXwUqrfpl4Nypd1sApxrzTnAMQgFhd8cpbB/Ae+PoeOq2YzfxXq
	 ZhpM7gc862iOPIffJWKizeKtyb4MfGY6hQdG8bgQKen3yvDFZ7mE/WIl5XwQDWGrkkUbb
	 75UnzEw/YfwXo5lD8UpXX1dDxtiUhg1EF0kLGsfTfkcCh9nzH3I+fqlAc/H8R56hetg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6k/zLBs9xN6Ge9pUwvUR+GztcME2OchPyVZ1lJ7jdb8=;
	b=rlbA95CMVevt1D0xCHA8cigR632ho0jlkS8h9vP7toO+KGvt3cTIo77x0fUi/vgAIirv
	 Vnc4Lq4UwAesgyN/vFKF5P60h465Lh+kC/YMlgbXHrxhoJtqx28fziqRh77IL44VYPNBB
	 6F/Ojq2//FmASofiW4zSmF8tzaxPAcBMU3EEkNxqz+SqnOcamicaYKwITQlhEJx6qwUnz
	 QmOvmL9fRp11N7IsQBTivOFPkyEFjdIosnm3xDLnvE/DL7f/vBZjMOBUd6Q01c/VqjsLs
	 HEU/0VYuu2D2MJ84FukkSx027r3ZaH2Z+JykmM6C0bPZ2riZ+lyoqfPWyq2tMbF8apg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkwMvimn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC659606A31B;
	Thu,  5 Nov 2026 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkwMvimn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C05B1F000C1;
	Thu,  5 Nov 2026 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889536;
	bh=6k/zLBs9xN6Ge9pUwvUR+GztcME2OchPyVZ1lJ7jdb8=;
	h=From:To:Cc:Subject:Date;
	b=KkwMvimniXwBHxMOIPpjFjX71BkUM9houO3mW8OlYVoBSpXHmJeDdTBNIhe6ATyFo
	 KGJO0Zt1W26J95hAtKMPmLIJSsoRDVJojBLf2HGIR+hWCaDAuA+B+12NyA0DTuESjX
	 p6J38vJToekd9S8jsJg0sZ9ZeJa5Y+P1nJewO5I2+ItHhpNOm+7QAqn4zhss3ezSaH
	 gd/4N9TJtKmfSUVq32cLIXmMWMoNOI7amNOx4LwW07YJKLvHpDefE+vXydeIM14hQU
	 NjSBKLZ+zLh5GFG/mkUPqVAnA1hSyiIXX6JHBdt1ZVJamvn8ZuibiV6Q5b+h2/1vAo
	 cB8Wh9J1coLpA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	David Lechner <dlechner@baylibre.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Grant Erickson <marathon96@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	imx@lists.linux.dev,
	Joachim Eastwood <manabian@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Juxin Gao <gaojuxin@loongson.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Lokesh Vutla <lokeshvutla@ti.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Philip, Avinash" <avinashphilip@ti.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sai Masarapu <Sai.Masarapu@imgtec.com>,
	Sandipan Patra <spatra@nvidia.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/8] pwm: Fix various bugs reported by Sashiko
Date: Thu,  5 Nov 2026 14:38:02 +0000
Message-ID: <20261105143847.2559586-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
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

Lee Jones (8):
  pwm: tegra: Prevent 32-bit period truncation and division by zero
  pwm: mxs: Return early when disabling and fix error-path clock leak
  pwm: loongson: Fix 32-bit control register truncation in
    pwm_loongson_set_polarity()
  pwm: axi-pwmgen: Enable clocks before accessing hardware registers in
    probe()
  pwm: fsl-ftm: Enable ipg_clk around regcache_sync() during resume
  pwm: omap-dmtimer: Handle negative error codes from get_pwm_status()
  pwm: tiehrpwm: Enable runtime PM before registering PWM chip
  pwm: img: Unregister PWM chip before disabling runtime PM and clocks

 drivers/pwm/pwm-axi-pwmgen.c   | 20 ++++++++++----------
 drivers/pwm/pwm-fsl-ftm.c      |  7 +++++++
 drivers/pwm/pwm-img.c          |  8 ++++----
 drivers/pwm/pwm-loongson.c     |  2 +-
 drivers/pwm/pwm-mxs.c          | 32 ++++++++++++++++++--------------
 drivers/pwm/pwm-omap-dmtimer.c |  8 ++++++--
 drivers/pwm/pwm-tegra.c        | 14 +++++++-------
 drivers/pwm/pwm-tiehrpwm.c     | 15 ++++++++-------
 8 files changed, 61 insertions(+), 45 deletions(-)

Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Drew Fustini <dfustini@baylibre.com>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Grant Erickson <marathon96@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: imx@lists.linux.dev
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Juxin Gao <gaojuxin@loongson.cn>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Naidu Tellapati <naidu.tellapati@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: NeilBrown <neil@brown.name>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: "Philip, Avinash" <avinashphilip@ti.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sai Masarapu <Sai.Masarapu@imgtec.com>
Cc: Sandipan Patra <spatra@nvidia.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>
-- 
2.56.0.398.g882cbad275-goog
