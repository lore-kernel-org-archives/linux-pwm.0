Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91E38735D;
	Wed, 12 Aug 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505046; cv=none; b=jO7f+0dCHqEL5FsrRxwFGaO5QV+HtE1HO2GRRNHUPqq8nsjOQTIo3YYA8X5g8naZ1oVVGCuD59+1Iw2bjHH3Q2Oqus/wTjmOhbgNvkFUG7fUkzNr9X0r0pqo+pEDKc2M/BMikMFyfu9ZLGbCQkra2/SbDu9u2PKJNeyKeTAua0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505046; c=relaxed/simple;
	bh=koF5tRe0d+hPSJInPiYXuK5p+J7czy7mQN0ECKniOcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGwIMzwlVEmhxoOvJ73gXQ2BmfoGChtLfUdBVoW3f+gf2aQ6GZxuoVo8d96knRpK8Fg65HD8vWEk1bEsJsCS9X7iYB1coHMSxdK5jh5RjnZGpI0G2W5b0aQ7x+jhhPIg7eOIfk3Pv0fDRHsrtamdDFQCnZYU2vGaWR5aVnGwTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGGQrXXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGGQrXXL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85537C2BD05;
	Wed, 12 Aug 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786505046;
	bh=koF5tRe0d+hPSJInPiYXuK5p+J7czy7mQN0ECKniOcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lGGQrXXLzoynzhJwH+mhg08cDon7OIrrks1SeMy3DrrwfXJZ5EJLmWpKwwn1nf22E
	 mYqboeBIFZsbGTnSlloAN+ve3G7HktdMSZfwfLAlttVY9Vd53wbtzDIcvNeHfYtiyT
	 nruNsEHemsr7exySzzLN7b+R8ZTv41gBsW2eIa/mdHHYcszZ+USW7NB3ybYXC3fLZG
	 kPKRjXjFJh+LZDgta+eIfjFLfZ0hCCa2YVGHcjAoM+eD7W0lvYo8gqqBR2MWBPoEj1
	 Mh6I09OwN8Ss6dbDNHWpRGnOn5yrJGweUSdH1sUXAmyMpvqBvH0CCkhaUQ5LBX8FRN
	 cTrvoTR0662Wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F54C5B567;
	Wed, 12 Aug 2026 03:24:06 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 12 Aug 2026 11:24:06 +0800
Subject: [PATCH v7 3/3] MAINTAINERS: add an entry for Andes PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-andes-pwm-v7-3-a806da8185d1@andestech.com>
References: <20260812-andes-pwm-v7-0-a806da8185d1@andestech.com>
In-Reply-To: <20260812-andes-pwm-v7-0-a806da8185d1@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-09770
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786505045; l=764;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=gjO6IZe5Ik4Z5BEicWOc/F1VbekVfs+WHY+c4FTLRSM=;
 b=wJ+LQWuuwY7kOate1QP4hWImy2xdHaluN1e2FeIkIeGyTo1DYF4fQSmp958EGGWqU5yKyH1wT
 hmIRtz+XJzSD8RWJ+n0pzIt2RqDDbUoq0qu147d40XqqpQlj8ZfPu4P
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
index 15011f5752a9..dcf16c40a99e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1938,6 +1938,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml
 F:	drivers/watchdog/atcwdt200_wdt.c
 
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


