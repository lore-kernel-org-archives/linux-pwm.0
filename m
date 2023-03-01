Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B755AC64ED6
	for <linux-pwm@archiver.kernel.org>; Wed,  1 Mar 2023 08:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCAIRs (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 1 Mar 2023 03:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCAIRk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Mar 2023 03:17:40 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874839CF0;
        Wed,  1 Mar 2023 00:17:34 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 097A024E261;
        Wed,  1 Mar 2023 16:17:27 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Mar
 2023 16:17:27 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Mar
 2023 16:17:26 +0800
Message-ID: <a267f495-6a49-dae6-84f0-098e9868840d@starfivetech.com>
Date:   Wed, 1 Mar 2023 16:17:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 0/2] StarFive's Pulse Width Modulation driver support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230228091345.70515-1-william.qiu@starfivetech.com>
 <Y/8IYSYOsDrGIXzT@wendy>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <Y/8IYSYOsDrGIXzT@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 2023/3/1 16:10, Conor Dooley wrote:
> Hey William,
> 
> On Tue, Feb 28, 2023 at 05:13:43PM +0800, William Qiu wrote:
>> Hi,
>> 
>> This patchset adds initial rudimentary support for the StarFive
>> Pulse Width Modulation controller driver. And this driver will
>> be used in StarFive's VisionFive 2 board.The first patch add
>> Documentations for the device and Patch 2 adds device probe for
>> the module.
>> 
>> The patch series is based on v6.2.
>> 
>> William Qiu (2):
>>   dt-bindings: PWM: Add StarFive PWM module
>>   pwm: starfive: Add PWM driver support
> 
> Is there a corresponding dts addition for this driver?
> 
> Cheers,
> Conor
Hi Conor,

There is, but after communicating with Hal Feng, I decided to upload
bindings and driver based on mainline first, and then upload dts after
Hal Feng's minimal system is merged.

Best Regards
William
