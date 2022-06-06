Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3377C43334
	for <linux-pwm@archiver.kernel.org>; Mon,  6 Jun 2022 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiFFOdt (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 6 Jun 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiFFOds (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jun 2022 10:33:48 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 07:33:47 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157B2BE9;
        Mon,  6 Jun 2022 07:33:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B7716601E8B;
        Mon,  6 Jun 2022 15:28:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654525710;
        bh=x7xKY5UUVqxnt5695zeWx8FCmwvNi3Mq8k7CtIwGYG0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m5zy97b2177AzVbPV1k8kS6LsuZ3sO1+vG5fn7qDs+VulYToDd8FeSkekArpUCKu3
         She6nj230USZpPYifATZ45fjSvGs7qTimZwuB9cZLwhFu6uUBA/rytH7F9SVnsoc1f
         mdXnxdcQpb42pPHOhriV/coO/XkMeGmI6kAWY4GVDkqfPHfFpv9rvhN+cOaKolFPUf
         O9F263uN2FCDvQ0/xWQWMdGfAA6goCvc0WkhCe+cahuagJjA76uPo1RFjWHSljF1MH
         HOD9HWuo7sZh58TeXFdw6mOCntLJXWVfi4d60TMOTaGvdTMmOaZejLZ8vJ2Gb+DPm1
         uNp/n72zZ/bOw==
Message-ID: <eb1c3713-b6a5-5f5a-fe22-75117b85971f@collabora.com>
Date:   Mon, 6 Jun 2022 16:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek: add pwm binding for
 MT8195
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220531114544.144785-1-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220531114544.144785-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Il 31/05/22 13:45, Fabien Parent ha scritto:
> MT8195's PWM IP is compatible with the MT8183 PWM IP.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
