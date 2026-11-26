Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703457;
	b=jmebdbo+cJ+ikWUTMHUZpUa+kHlur+a/k4WrDJJjxzkZ1yMr9ZgISuBWi+/32HooqJWg
	 szd5m6OnDNg5xkE4hCGAiBiVQg6uyE6qe6z5Xk/c7HCOvm4pp1RmVTpJE+2c1iCAjzEuz
	 LygZuU41AA/aoOFhLYLYzYb/FwZJnzyaWFs38Y6PvGy1RFp8jnQ5qYtTQCKG13mOawq7l
	 wxUI7HUKVJqOYMOPV1KvEDy0AItqmlL70cp84Qhi3ko0WZc8ZK2iVPuXHNlTas4zHG3m+
	 9yZjG3WHbWX4VcflPQx8IglPCMd4XXEDpzwi3lbZZumbZU92iu9DNji4wF5gfFYjTuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bhjx/ath+sZuV0+nGHM7slA63K+OA/qHJM3pgi+RkQg=;
	b=3/jZ6rQgL7d5SjtJ6Wx/I+nouA9zv7nKRmIz9IDj7MychNHL7FdQPbPzzDGZzpqgff0a
	 SndxEMfNOdH6sE46acE847Yc7bHIFoTWdqQ7zDZbWK+aSsio/Xu6oaL7HFeqZZNowtsiS
	 CCBclnWYzErGYsBOU194aJa0N8rjLrlcmOGbJ2xQC0SmKFNgcFy/Y7kRRuQo+AQnk4aGh
	 ZrwSSdUIwCZT8Ypn5etatiZ4kzDEohPRXcwWaGCNhVcOPIzdyAkqCHuXxKDZ2UzOKRghP
	 WWHZe97JjG/515vkG3J2VDnFGxcaHFxAMuvyUiap9J+jjWq6Vk5jDnjf6a2jjhm9Ehw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H8HOHuz/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA9606A698;
	Thu, 26 Nov 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8HOHuz/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED34F1F000C0;
	Thu, 26 Nov 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703457;
	bh=bhjx/ath+sZuV0+nGHM7slA63K+OA/qHJM3pgi+RkQg=;
	h=From:To:Cc:Subject:Date;
	b=H8HOHuz/mP1Q+w4VDLFEhy4Y/dqemuhjrFjZG0YULa0CLbZLLOBxmf4wckiXe7u8q
	 J/pdZUDBLansXk07zCs7gOKYMjrnhWFTCU8AaVThjKKXIv6/r+zoGLX1npBkYCeFLr
	 nreiWzX7+WDGR7QcRsfN6n6ngFTRI1ScJtkq1RoMZf1U/qsQf7ipzkyXGbBWawPGfc
	 tNSMGTHwd0eR5t6eYmWy2qfKdsEjEpN8qhy//lmxiL7bb9P7Nh5wNNy2dagKJrHJF0
	 +d+ELGbz1i3Qo6rR27es3avwP/KmLG2uxRubLRU/VyKH7zYTpSAuNyhFR+5T55vYmi
	 hcYVLRXe3KFRg==
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
Subject: [PATCH v2 0/6] pwm: renesas: Add R-Car X5H support
Date: Thu, 26 Nov 2026 15:30:35 +0100
Message-ID: <cover.1795702568.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

	Hi all,

This patch series adds support for the 16-Bit Timer Pulse Unit (TPU) and
the PWM instances on the Renesas R-Car X5H SoC to the Renesas PWM
drivers:
  1. The first patch documents support for the 16-Bit Timer Pulse Unit
     (TPU) on R-Car X5H; no driver changes are needed,
  2. Patches 2-6 document and add support for the PWM instances on R-Car
     X5H, after a few customary refactorings.

Changes compared to v1[1]:
  - Drop platform integration patches not intended for the PWM tree,
  - Add Acked-by,
  - Add Reviewed-by,
  - Improve patch description.

PWM instances 0 to 5 and TPU channels 0 and 1 have been tested on the
Ironhide development board using a set of blinkenlights and a logic
analyzer.

Thanks for your comments!

[1] "[PATCH 00/11] arm64: renesas: r8a78000: Add PWM support"
    https://lore.kernel.org/cover.1793026273.git.geert+renesas@glider.be

Geert Uytterhoeven (5):
  dt-bindings: pwm: renesas,pwm-rcar: Add support for R-Car X5H
  pwm: rcar: Use FIELD_PREP() for PWMCR_CC0 access
  pwm: rcar: Add helper variable dev to rcar_pwm_probe()
  pwm: rcar: Parametrize cycle counter field size
  pwm: rcar: Add support for R-Car Gen5

Khanh Le (1):
  dt-bindings: pwm: renesas,tpu-pwm: Add support for R-Car X5H

 .../bindings/pwm/renesas,pwm-rcar.yaml        | 61 ++++++------
 .../bindings/pwm/renesas,tpu-pwm.yaml         |  1 +
 drivers/pwm/pwm-rcar.c                        | 92 +++++++++++++------
 3 files changed, 96 insertions(+), 58 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
