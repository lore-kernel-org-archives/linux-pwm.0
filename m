From: "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 2/3] dt-bindings: Add "sifive" vendor prefix
Date: Fri, 27 Apr 2018 15:59:57 -0700
Message-ID: <1524869998-2805-3-git-send-email-wesley@sifive.com>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

This adds a vendor prefix "sifive" for SiFive, Inc.
We make chips.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6..c98faf7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -315,6 +315,7 @@ sgx	SGX Sensortech
 sharp	Sharp Corporation
 shimafuji	Shimafuji Electric, Inc.
 si-en	Si-En Technology Ltd.
+sifive	SiFive, Inc.
 sigma	Sigma Designs, Inc.
 sii	Seiko Instruments, Inc.
 sil	Silicon Image
-- 
2.7.4
