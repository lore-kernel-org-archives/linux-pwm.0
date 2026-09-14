Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452144065E
	for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384073; cv=none; b=iyqP/9zFzhbutpdJhpd0nMYDXdVsNd7wE/7SI7+N9prJNBUWnp1JmRODn/dfxMi7ZuSMdvwKyYm88LscsogXTSlas7zTcCHYh+oR1CUhaJSSLjIHc9niHl2tfU2dWN2OtzJMRPNaPSQg9sd6rp1tYtk21dFCy0gVCYgURILAk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384073; c=relaxed/simple;
	bh=10R457NwGTvH71mGj5Kfmru+y69/XctIcBwhK8pKzak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7nZ76BqV0Ir/dTbnzqHrY0x4AH629RGixtTpEn2fVYXbneGu5Ms/fn54zgARY8y3lQQL54qf0ZInIe3KBAd2xPjdrycee1C/EdymJRJFDmHy1GRQjRhukve9WjFJkNeAYnny865VhjLCONmKhcgHAa9uUVSKkUXhsvtrSnpEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrrJuZPi; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrrJuZPi"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so746111a91.0
        for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384071; x=1789988871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=KrrJuZPiV7i+7USsDBMaltpv5NLKajZ94OMG6U+oSfvYOspwGbZLly0dqcG8E+Q01j
         i6IZBii7ruhRq1VnbxB4jpQnqcGGiT1WprYmGbxBKp4+4ZxjPA18utnvNYbaMH0HZaP5
         sX+CzYLjk4paJv7S+hbGHbZIpMjMTDQfvtqVtbFrAmzqV1fMNCOBV2teY2iXhroR7pz3
         oPqy3TcWuab+DwSVRb5V5KcYIFANr2tUmDSjKb+78Eu9B8v/uxmCDbxblIcsTUEy4eu1
         4ScbmVTweFDeMcUCX18W0JwC+okI6axKy4hmGSVVACTdidY5aG8gOSHXgMbsstGyhYtK
         eieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384071; x=1789988871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=FciMWrcLmqj+VQcaiZ4yoXFQDg+EOtu/26RaGzEHzhkQOGvqwm7T+bV1XQehHiez+1
         oECL/Twp5nXX3gTBejP1HRnEoe7mE0KzAUfbm/9D+xxD2yMfBhffKTQ0yfRbH8ACTeCk
         48atTuGx1EgLEqqsYwX4pY2USH38FKuV+0AJTqsCQbm97iu9RlcIsJS1nvoHoBVBDBpF
         JA1242q970IWUorD3sUUSR+wykDbkrb/pPxE0E97HyI2C6mstPcsBNGvI87EAn3stZTa
         DyJYjGd9WW/hGZYWNO59tQe/7nY/d8zlb1QOeJNE/No2aUKDYydRlkoITVuwb2kjtzEy
         /VzA==
X-Forwarded-Encrypted: i=1; AKwUvBz2WKvCVXVTTfCqxU7WmjQq8ET2+hgRePIDL7UCsirxXQSp3AtCYIslgSb9sMGnw4EOS8VHMYPeQZU=@vger.kernel.org
X-Gm-Message-State: AFuF++nsrDOin4N4HGhOeGW/Sl/rlaRIX63DTIPP/2jnCd9X/1tLMLSO
	W0mw6pXJNlQyRkCbmmGHv1fF0rnAK7AJ0DBZL3UghLd6ZWxl8WiXMOZi
X-Gm-Gg: AYBFou2RHEzxa1eaoN6nI/tlvOHL6RnHoMXREHSPQAW29XzBJnUIXJRn4bFY9u+LLFg
	23NLhkuY6WXjlMyZ7Izb4wxBShZM3UBgkU2j5Aw/NlblMSQiW4Qvsn+5fvHQdA1EYYeQc19svS1
	bknlUpINkSH8DOqqXEarKWvmNKq8x1r32w1Rr6QQdUvSRHhGh3U8GI/BJUzfxnW2tC3UH6OK+KJ
	Q5yzvBJfCFbyvdvEu+aYQYphAgP0ywWaxZmFpb67arGAee8SHx7TD4VX0jtxR0aUpt3YWtvMCty
	DZzHz69VlOvxP6woodVnlmTVeu01/yhMNkikTWzFGEDZx+PN2Md4P9DZMNhbUWQi+d+xLzdrNhk
	V430DQNhUc8CeQtIkLFnaE0s8enhRw7aPiHgJxKOUO9/d2KRVNFJzG4ntHIuzo3kevUtxBz0+dl
	h0VZrPB4DF0avVMA50qZTC+2KbaJMu9lVzaBMV2dCxqxdW6LZ74gvoFZazthtAQgebHJ3j2KqbU
	USrD34HPCN5WwbDvVMImYW1aSPRqzafdFhfjp9RZl0bgf6OlV5/WoNg3tMt
X-Received: by 2002:a17:90a:e7c2:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-39dec497e11mr2160746a91.10.1789384071050;
        Mon, 14 Sep 2026 04:07:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9540fd76sm22996627a91.9.2026.09.14.04.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:07:50 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: pwm: Add Nuvoton MA35D1 PWM controller
Date: Mon, 14 Sep 2026 19:07:38 +0800
Message-Id: <20260914110739.203479-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914110739.203479-1-cwweng.linux@gmail.com>
References: <20260914110739.203479-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add device tree binding for the Nuvoton MA35D1 PWM controller.

The MA35D1 PWM controller provides 6 PWM channels and uses one register
region and one functional clock. The binding uses the standard PWM binding
with three PWM cells.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
new file mode 100644
index 000000000000..47a59bdd14d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nuvoton,ma35d1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PWM controller
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pwm@40580000 {
+      compatible = "nuvoton,ma35d1-pwm";
+      reg = <0x40580000 0x400>;
+      clocks = <&clk EPWM0_GATE>;
+      #pwm-cells = <3>;
+    };
-- 
2.25.1

