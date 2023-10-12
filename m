Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA3CDB46E
	for <linux-pwm@archiver.kernel.org>; Thu, 12 Oct 2023 10:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjJLKHv (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJLKHv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 06:07:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AD9D;
        Thu, 12 Oct 2023 03:07:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E00C433C8;
        Thu, 12 Oct 2023 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697105269;
        bh=gVg8UtHvBvE9+HDyXHQmUlBBjz6PEyk4GmrjWTk7gr0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hsd4x/JVT99DmsoB74tYqpbwpnDF8rRlK5umPGx7M9ndz4t68IAiK+HBaV95e8ikz
         H6EniSCqf+vmv09fSNRc9s2J05jamDQnnLXmn+4o8pCKu2/ZAFWn6Y2F+iHw5Eslba
         V3qHpo9S5GVy7tiDYs5FJjm7GGC1G1E5Clh325RHvX44JXRqHv+SMhBS1og010lzZR
         uaoyO2w3iPpI3WT6182TPmV8+94P6PQ0wuJbzCebVO92NYhf8NzxIzp5f0n+2ZucJQ
         TqD1bajiQ1qGQAHLAUCzb+wRrsIRFoyfhT+yhFLMHNIeIih//oX/Q0WlLI+qxZ9DQa
         U7zNxQKdWIfQg==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, baruch@tkos.co.il,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20231006045317.1056625-3-quic_devipriy@quicinc.com>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
 <20231006045317.1056625-3-quic_devipriy@quicinc.com>
Subject: Re: (subset) [PATCH 2/4] dt-bindings: mfd: qcom,tcsr: Extend
 simple-mfd & pwm support for IPQ targets
Message-Id: <169710526675.1167576.9872640040047520620.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 11:07:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 06 Oct 2023 10:23:15 +0530, Devi Priya wrote:
> Extend simple-mfd and pwm support for IPQ5332 & IPQ9574 SoCs.
> 
> 

Applied, thanks!

[2/4] dt-bindings: mfd: qcom,tcsr: Extend simple-mfd & pwm support for IPQ targets
      commit: abbb729360a50ce949de94a983cb56b15b82018e

--
Lee Jones [李琼斯]

