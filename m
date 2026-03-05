Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99C378D79;
	Thu,  5 Mar 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702438; cv=none; b=hwcwvQ9EtVlp2rQWXugVAZHiX0S+nTap2J6tEk3rJpkzWm9gW4TryPlj6Rnh7fvry1oYxKc2rUP7temRJ64Ryd+ifNG9dlo+JI6LHoa+pxAoWeISidVQuNUa0ddNmRDd4uM4KEJ69CSLwke7xlLZRbuuEYV0suv/TJTG3AXLhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702438; c=relaxed/simple;
	bh=Y4eVT7/NuSZJqfzVtHxzqyYTOGl8de8J0xxTjcXvpls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK1l2yHgNPrEZk8Ki9SZ9oycXliv6jXXuaN90esNtNZSEqgi3DH+1IkYNBU9z6ZK+EgLviNW1meyOuLuY8CorgaF0RbRnzYx6WVZlW6Q5c83BJ4oMI3NO4+QhtxeyAZyCvNTvc1XA7GtRhmS0E2vfiP0Ri63fAClpDbaLClvP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tSJh4rNX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tSJh4rNX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 08D7E1A2CDD;
	Thu,  5 Mar 2026 09:20:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D450E5FDEB;
	Thu,  5 Mar 2026 09:20:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 875EF10369849;
	Thu,  5 Mar 2026 10:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772702434; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WcLNzXl21Z0IGz5loeaMz5yAKbSvSMAru23mD8/dYjg=;
	b=tSJh4rNXf+8kqYmGWjdJRtL1YpUdmBC6t6JuEW42eXnjw0td/WVuYR3U66a5O+Uwod4OYJ
	fCztOUWsGmdatP5yOYZBx30Yy1Hx/cpz11HwuIFK09mg9kZP2WjFTHOKsNHvHWj/xUQgpt
	mU+VLHE86bgHNXxgJEImx2WbjUjSF9EifARjj6ee/Ev5URpTialkzgEtta0LsX4h2h1OFQ
	BxwRujlOM0QzrGgtyc2rK4rgRfvtxvkpz/42qn50dPJxsVmi7ZxIFETLm4uFzBU2YV903c
	Y3wmcSy4WyUG0zCCmulP+FTPWDlv1PBLYa+MNQe4ubnudAIbKuR0u3GcE7Ap/A==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	John Stultz <jstultz@google.com>,
	Joao Schim <joao@schimsalabim.eu>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v4 4/4] MAINTAINERS: Add entry on Allwinner H616 PWM driver
Date: Thu,  5 Mar 2026 10:19:59 +0100
Message-ID: <20260305091959.2530374-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305091959.2530374-1-richard.genoud@bootlin.com>
References: <20260305091959.2530374-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add myself as maintainer of Allwinner H616 PWM driver and device-tree
bindings.

Tested-by: John Stultz <jstultz@google.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..de284487242f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -906,6 +906,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
 F:	sound/soc/sunxi/sun50i-dmic.c
 
+ALLWINNER H616 PWM DRIVER
+M:	Richard Genoud <richard.genoud@bootlin.com>
+S:	Maintained
+F:	drivers/pwm/pwm-sun50i-h616.c
+
 ALLWINNER HARDWARE SPINLOCK SUPPORT
 M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
 S:	Maintained
