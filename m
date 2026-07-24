Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AC41B36A;
	Fri, 24 Jul 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917021; cv=none; b=mM+rNNUpxv/AaZdfkGIojRQWylui3vi3Qf28LNWG2ynDErhGitYIu2tu6WaXYMgXjhI37yNjojzIPR/khBrZcip/4p0W+9NIvdVGLBryQrLBf13N1J6bktAo7UbtUMQt3Cstrc6RNcRdKoFEK3ic+Yv3eNnp2m2uLg7pZwLoRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917021; c=relaxed/simple;
	bh=AKZYad8jBRwy8Pq5GWuDAVzKic6oS+V16a1/1LfrzSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ke4QOXJUFVzyT7KejCovjBujHKfENBHadmpN/qyi+42jK3mBZE88ji+jy/xiv8dUXNdll4pHcB0W6p604i++A1yXzOvhUjzhhi1SH0O7lmCCOXWUdT6ueDkVMIX2WOl7UmD5i3rnohEJVEAFeNOj62p8peB3OH+jbbkVTPujixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=E1R+nsBi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZA6N9iCR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="E1R+nsBi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZA6N9iCR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A932C1D0041D;
	Fri, 24 Jul 2026 14:16:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jul 2026 14:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784917017;
	 x=1785003417; bh=rvhLOY3hzP177IpyHpIG/dUjluPVFDcaiQFyb3NdBmY=; b=
	E1R+nsBicOnlgJVuFZ3X7ZFdamrT90fs4G8m0Uzcb5zzdHfLJupQOoG1UKzhZ8qQ
	YeVga51q1CKdsu4aSWycnl0C5iASo2VFQ47Les5UsMaH9/WCyHgftIoApzNKB/LO
	dFcbCyLoes9tmC2BLBJHxYhxYhMPC2AgIYUf/tgmlqaJclwIi+5uKi61SE5YuN24
	4ZaFtTl0HgdH7pO90Q/NehS6ICsPfBLJB9PI5rUHKqi+rwwYZoOZO2XD/J2M3mlQ
	Yak4LqPik9SBgqhTeMFLYyPROSdmHP+y2WniPkuP+WTQdV04SjYMTyQ5XlhADcQO
	lOl3Z72pk49+gQAJ+wfLLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784917017; x=
	1785003417; bh=rvhLOY3hzP177IpyHpIG/dUjluPVFDcaiQFyb3NdBmY=; b=Z
	A6N9iCR9upJtfeKu7LCIg16pat2B377V+tlNgKIYkr5rFzgecHuaI/HFpyLAse6P
	PaLNOEyD8iuyobLttv8z/rkKx4MGifa8Qji3Z04RjyvGVrmwvSlVyDYZggU23WW/
	kzvF6TLHZZLFEA40mt+OjKZXPds/kHuGcynFflzoes0NRSaTW1hvDU5hPG5ishc4
	GENbumW1T3f89YfOCN/sEcS/LZVPsMCFwxZf2KiwNUq2KtKno7o8vv3RojlaDNrv
	a+DRsbjJFs0g6MmJmnEZ9mz9LarjlW3sYNFF8OC8JPtGtgcGmR1+PHoCYuoVTpDD
	I3Xd2BePlFfag/TpG+2Pw==
X-ME-Sender: <xms:GaxjavNr6gHovjeH9RmZlhxKFJPOLNm9gKqOIJh8Efsa7qDAuJFcKQ>
    <xme:GaxjakP7j7hJCEDPpvzLlW9oIUt216whOjBC532efnZHt6zjicTvioJBOdi7WU-Fa
    Ky8PVArOfqfU2g-d5Bz1UVvlrpNl-MFvYpjpZUrjw1ve2h2Y0TVX-o>
X-ME-Received: <xmr:GaxjajvJ-EmKlFi97E6qyKHTCgNLGI_FEmNlXCo1rxTX-OBmLl5tma8viWH3R2XnpUoiHosob4VKI_0bwLMvKj39XM4DGhyER-8>
X-ME-Proxy-Cause: dmFkZTFn77SKaNLLHGcFk79AmrIEXiPUsMLPyGOV3ahYqRy1TcCvAaQADXiJqRyDKXSPrq
    c+8fcCpPqn8ifNT/ny0r7+7GKFQ3KMiXAR6ugGIJ02AfZphYt41WuA85SGpwtlUzOLuqSs
    HQLBO8pXHo4NcdJHw9ExsaYk9J6E35Yw0x9hu3xHQYx0SIDgX4OG7nOhe4wLlfiqbXWJfS
    7xor45FXZMEpQN7lb25MUCWcZkuhFnuBnqiMPO4ZsbvF7ENQj5Yiz7f874C+2CKt7V8MQ1
    /yaLRi2baR1tPugR859S9x8ReVhk0tPAwe7q+vt6UvNihLV/OcSkYrzlA6e51p+WVnX8mL
    apRv/J3NpDSYYYP4pLpsZNdsdmjeMfFUGYHV8hyEnxrL0pXEyyETg9LjegIADElQihAc6v
    rUrXgcX/kH1O3/cTvwHgpXBif9v90RPLaGpWIxDFz2fts1sZA5RdmMhfTT1s0ghirMRQcq
    tyWVJGuggH8IcWg3c08scBIC9uPa2UxXXvQP+mdQgS+xjOZUmGGLHR7hjm0AYrFP7ic7HK
    LMbjII2BYxkDhpkixFAZgWGfqyEx3fBKNujmLWNbD8eIGSXEeZWXVWwFL97tcPq+z4A1/K
    W0FiE2/avPHLz0ykCndqQBesGK4hJ4CyJxovw8PcGKNU1aJy1dhJxt9FlDxA
X-ME-Proxy: <xmx:Gaxjap_Pu_qjabkh-tZu934CfXt2tC0HhrWtlzSPekm5ePP2rb0a9g>
    <xmx:GaxjavHXLinRHuULbr-9CSyoT--o0RXflfXz80HAhA3YxXL8riaXDw>
    <xmx:GaxjagQ310rocV1tV_TNpqJxrAcDL6WJOYrYVi0OdnMA2E94j-eolw>
    <xmx:Gaxjalu7tmzQtBdpsIU168EqQHeaSFvcTbSUPMzULG_laQspxqkdxQ>
    <xmx:GaxjaoVmFtSDqMcE3PycNZRtiQCQK9LawyNA4OffYu_aZWUeYaXM_ZIe>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:16:56 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 24 Jul 2026 20:16:42 +0200
Subject: [PATCH v3 2/9] dt-bindings: interrupt-controller: apple,aic2:
 Invert #interrupt-cells condition
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-apple-t603x-initial-devices-v3-2-bbeba0420603@jannau.net>
References: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
In-Reply-To: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=j@jannau.net;
 h=from:subject:message-id; bh=AKZYad8jBRwy8Pq5GWuDAVzKic6oS+V16a1/1LfrzSg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNbwWPLGcy7dN7FH+lXsmalZ86/pNJQy54kleew/17
 t+lnmffMYGFQYyLwVJMkSVJ+2UHw+oaxZjaB2Ewc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATPXM3ww/5p25m9mteK7OlfnG7OzuPZK5xWkik6W6/k1UzgxesmstI0PXpN9nLWx
 EOB+YTJT5suaXquVd030nkgS6fKfemli//S47AA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The condition for 3 or 4 #interrupt-cells list compatibles for the 3
cells variant (not used in SoCs consisting out of multiple dies). This
includes the AICv3 base compatible "apple,t8122-aic3". This will match
    compatible = "apple,t6031-aic3", "apple,t8122-aic3";
shared for M3 Max and Ultra based devices which require the additional
interrupt cell for the die number.
Instead list the compatibles used for multi-die SoCs explicitly and use
4 #interrupt-cells for them.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/interrupt-controller/apple,aic2.yaml      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index d0d9a90e96e7..a94787939d34 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -128,16 +128,16 @@ allOf:
         compatible:
           contains:
             enum:
-              - apple,t8112-aic
-              - apple,t8122-aic3
+              - apple,t6000-aic
+              - apple,t6020-aic
     then:
       properties:
         '#interrupt-cells':
-          const: 3
+          const: 4
     else:
       properties:
         '#interrupt-cells':
-          const: 4
+          const: 3
 
 examples:
   - |

-- 
2.55.0

