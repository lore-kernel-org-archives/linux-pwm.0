Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C63E9F8D;
	Wed,  4 Feb 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204314; cv=none; b=ID+dLhbg86Vn+alytSjJt6qbVWS+gnQboBBupAoVXSR11SiEF4VCWC4TkvFOfJaPAC1+XPjFCXT+3lJDvMT6oEu/0XAC18/DTOrgEvMYYuc6SMBTc4M3PrKDVH6s7/QAsmG7n/YdudP9KtI4yCYNXPD7USjaqeNxokCb020QomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204314; c=relaxed/simple;
	bh=fNS3C2NaCK+go2nQNBlkD9EyrNNHIb0CZcl2LNOQBmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFCX6/7rVL6Ng8mJ3Lrk81rI0DGwZkRDcI3fgwn3IGc9mWgQ0QOeix+I79jbSMZ7rvK2sePQYgfY/xx4FZGxUnBzEoAP/2VxXr0PhIsAjjc6VvRQImPAn9TRvwnT3dTF7KpYwPuHZ4R/rIhEgSO/kJSTSElL8TwLXAul3OPDt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J26tiq+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J26tiq+L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD12C19422;
	Wed,  4 Feb 2026 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204313;
	bh=fNS3C2NaCK+go2nQNBlkD9EyrNNHIb0CZcl2LNOQBmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J26tiq+Ljb3AtXnNJB99YITZHZg9fjBDCPv3EQLSfedawieZD3XoHG1S2zHFcCyDM
	 2vSZdWg6p/0yABhN7OCv82gJtvecdRjOoU3PrUXhfEHC9cavMzrmKPXpDDTX5liiw/
	 Q9Os3AV+RfX/1M7/F3XGUX6jcQfpQpbFp1o0FP57Ukjsv3Ib4BFjLIkfd+YKuWHqyn
	 197W+RVZpv3u8IHt7fGhfFAMYwC4mCvdlOm2yyk/8KjX0O6bbcXpBtoJiwrmkxX6mW
	 vyX94eTTxS2R0IKS4nyOWG+WJDIP3UL7g7sGWTQ20gxGF36FiM681OmtPKZvWxK3mT
	 /bM9vGabtcd1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9815CE95387;
	Wed,  4 Feb 2026 11:25:13 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 04 Feb 2026 15:25:07 +0400
Subject: [PATCH v20 1/6] dt-bindings: pwm: add IPQ6018 binding
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-ipq-pwm-v20-1-91733011a3d1@outlook.com>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
In-Reply-To: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770204310; l=2042;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=8ayVJ9z0kZoRdShrug1dJ1pjUonk4k9SO1yJzG93fMg=;
 b=Xjogr+JBgSkj89dNR4lbs5wwt6nsNiNMDvn77RW9Yq0JwjKTIcdlGeTUm+BDrkRqR9AbDA8fu
 Kl+vV+XspZnDtLSaskiEusMKhlrcWkFb9Dp6t0Rq7/3x+E1nCRvaS/P
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Devi Priya <quic_devipriy@quicinc.com>

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f9f1f652e7527bc8fb3d5fad51b0057ea53b3766
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 PWM controller
+
+maintainers:
+  - George Moussalem <george.moussalem@outlook.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,ipq5018-pwm
+              - qcom,ipq5332-pwm
+              - qcom,ipq9574-pwm
+          - const: qcom,ipq6018-pwm
+      - const: qcom,ipq6018-pwm
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
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+
+    pwm: pwm@1941010 {
+        compatible = "qcom,ipq6018-pwm";
+        reg = <0x01941010 0x20>;
+        clocks = <&gcc GCC_ADSS_PWM_CLK>;
+        assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+        assigned-clock-rates = <100000000>;
+        #pwm-cells = <3>;
+    };

-- 
2.52.0


