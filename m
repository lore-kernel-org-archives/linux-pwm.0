Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77445C77B72
	for <linux-pwm@archiver.kernel.org>; Thu, 20 Apr 2023 07:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjDTHsK (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjDTHsJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2023 03:48:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46144220;
        Thu, 20 Apr 2023 00:48:08 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E413A660311B;
        Thu, 20 Apr 2023 08:48:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681976887;
        bh=ve3558rEueim/3DSO9HICQByD/TQeBsw1a5e6r6QaCM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=XJT/f7MLZtDmbcF1Y65jzSIVFsO4NYO1j7sksvk2HJZQXVE+Y3AuCURqxGcRDBRiy
         fpXCE9jpmWLFeSVcioL1QlFZFv4m9GTF3QQo3Q+LFlC6GobddS/gtAP7y9ibSJqs5U
         w+8yDDYbjgeeLboD7zTNOoa6ykI+DSX+E2g8YCP5jMfLarDvC3p9wcyLbZrfVg8+/7
         tAGl4rNYsyIhIVq99hq9nNzBJfrT9RNBYEXW9PX4qTHl6JpZgbsmQoptj5samKTeiH
         34rwFBAAPv6CowhEnrOrHA6P1Ou7EmuEDiiIEkUfZVYaglkdFfBX2YMU1s5Z5Xyl6W
         iTHpsOtvu6Elg==
Message-ID: <48aace56-0965-b111-7644-b00b3dd7dda6@collabora.com>
Date:   Thu, 20 Apr 2023 09:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek: Add mediatek,mt7981
 compatible
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>
References: <cover.1681932165.git.daniel@makrotopia.org>
 <4877689269af862ea9ddd199d8aa96b2d7fcf6fe.1681932165.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4877689269af862ea9ddd199d8aa96b2d7fcf6fe.1681932165.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Il 19/04/23 21:24, Daniel Golle ha scritto:
> Add compatible string for the PWM unit found of the MediaTek MT7981 SoC.
> This is in preparation to adding support in the pwm-mediatek.c driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


