Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF03F0AB7;
	Mon, 10 Aug 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364199; cv=none; b=K1lOjdX9n3DuCA1aMmh4Cl0D5CO5qaxpyUZmEmpBajuAnzf/d8Yuw3lxbXs9x7Nyi9rk5XB6a6+bmhfpVrHRXmOFskTNnI8iuTkdCXPf8KVcUL/WuKVTETVjOm8Wi0hAJGfe34kDkthrPavHVv6R0h9SJxa6raQiZuN0QPQ4n5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364199; c=relaxed/simple;
	bh=gFT3B4iLUq9Fto1vIW5ndfyqUd7uv4MvIQnYb1oy2oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5lE9t0cBFV+Gm/oEowDAkEcWvWHT08gm97xmRZ4eqJXfk9oitozfncEVzLP74+GceGD7lfqZdxZc967msnj0bGNFbMfL5zMNVWWS7Ni3uxT6hqdHo9vebuT5D5/qeqjYfmyRpnT0GUNLKf88bnFow4frtP8g+R7hJY1vAN86mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=QoQQGobm; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="QoQQGobm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4944C0519;
	Mon, 10 Aug 2026 15:16:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786364196; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ycaA4zP669aUiie8zKyoviwsLCosDdRQ+6HaaafWNQs=;
	b=QoQQGobmRzM3gxEeKdVkx2BgbCm09kZqHISI75T8RbTj4qaJ3BY6BF5BZKwsEg36M9na7D
	SvTi9kaRdRhu5km1rWvfGMezx7UOeENFCSxyiox/L+6HkzGKtkviPS+fDRwJvlplMQhrbW
	2H280posq3dZNoh2sl3a+zgh+rMsGQI0bgQPpSexjjKgiW1Lzc903n+j0IqcSewXKoN8Ld
	lHVl3XqwzS1oYW2oUjXjyohuZlxRUZNbcwd0ClvEmTUhN2ZFTxTfVfxTgZj98X30WPlNLl
	yLp01qdmZiR6CdWnbw9MQvvR1sLr2VTvts41TNVhKiOqk9FhWu31WNPhXNdv6Q==
From: Vladislav Leonov <vlad@zlab.su>
To: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org
Subject: [PATCH 24/25] dt-bindings: pwm: rockchip: Add RV1106 compatible
Date: Mon, 10 Aug 2026 15:11:15 +0300
Message-ID: <20260810121121.210040-25-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
References: <20260810121121.210040-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add the compatible for the PWM of the RV1106 which is compatible
with RK3328 vatiant.

RV1106 PWM channels also wire up an interrupt line each, with the
channel that supports capture mode using a second one for that.
Add "interrupts" to the schema to describe this.

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index c8cdfb723336..8fa75cabf025 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -34,12 +34,20 @@ properties:
               - rockchip,rk3562-pwm
               - rockchip,rk3568-pwm
               - rockchip,rk3588-pwm
+              - rockchip,rv1106-pwm
               - rockchip,rv1126-pwm
           - const: rockchip,rk3328-pwm
 
   reg:
     maxItems: 1
 
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description:
+      Some PWM channels (e.g. on rockchip,rv1106-pwm) additionally
+      support capture mode and use a second interrupt for that.
+
   clocks:
     minItems: 1
     maxItems: 2
-- 
2.47.3

