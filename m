Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0F3D1AA6;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383761; cv=none; b=nOWIgDHdjGCXwSUCnyKU44A7Weg5xOWavTehlJZZVBCb3rWLkbaPV6gh/wa3GY4heM41yozcYf6NCQ3k3KwJmZ0PVWBwLwtsWR23dm5CMFIyl0QoeIeuAWyrU5nnDsZwyq86ajimMzwdTz2kkGKfsqQ9DSsQbjt4xiHjWc1khUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383761; c=relaxed/simple;
	bh=DZvJXYwiTn7NaQnx79Z9NMXtL6h62xhj1D2k3BWDEaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpvNdh2ZL3+F+BmSYESTEI98ZHRXwFwBud5Y7EGNZG1Hi/Xt8Bvz9WR9c2uS4f8DQNEZYAHWcdFIbd031WrBotAtnHxiL8TiHe1DOfy3rjzVeMbkmvbhTP0a3sE68ZXBTDczpushY83k3S5+iVKUAXg1IFCt790zNPSB4C9Qlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPUslhaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPUslhaH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4F42C2BCF6;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782383761;
	bh=DZvJXYwiTn7NaQnx79Z9NMXtL6h62xhj1D2k3BWDEaI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WPUslhaHiqqAYzxRNGnTQgsvCNQR+2oDI9yXqoky75kZR/x81bFOc5Xzh7+MgdfiL
	 ysexmd0RIVhtPGVQRZpHK96qG9XMYjl7xgRvdLVJ4F/cBaMGWfiT3f/pekSWsbdkQc
	 tanviBJkqZ6Rfy1p2JvkfevoHQx60/7JOxsYtKygT1LUrdy/qB7qhIeerKaZHkuRmX
	 x2fuTkvqegreUOx6Oyk7nNZtMVVfkuGVMCWotsD2ylAtLDjMGlPozi5PH0EJw8mX9V
	 LWFMqSJuLx4wlkR46/3Twdgysnlo7/SHobFULVV+ssz6AVdPzEf6WZlLOXFrTn/iiC
	 6vmv5T9brsGdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F8CDE009;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Thu, 25 Jun 2026 18:36:01 +0800
Subject: [PATCH v6 3/3] MAINTAINERS: add an entry for Andes PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260625-andes-pwm-v6-3-3aef11711017@andestech.com>
References: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
In-Reply-To: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782383760; l=754;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=yOiq6thqiSeGFGixy89XEZx9mM4JZgZkT7AgxcDK7ko=;
 b=3zYmry0MbDfZ6qEOXl09L9iveMPJuWXQdFkAsLJqEBaLVnC/WxE0FjOMNW2tHIGCW48tzduCu
 jW/JYPmXp5BCJRtCuy3qzrIjeTSODMUpfYS1829cqEChoOIeWRaQOWv
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

Add an entry for the Andes PWM driver to the MAINTAINERS file.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..2461683a5bbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1874,6 +1874,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
 F:	drivers/spi/spi-atcspi200.c
 
+ANDES PWM DRIVER
+M:	Ben Zong-You Xie <ben717@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml
+F:	drivers/pwm/pwm-andes.c
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>

-- 
2.34.1


