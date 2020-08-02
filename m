Return-Path: <SRS0=kQVU=BM=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9941C433DF
	for <linux-pwm@archiver.kernel.org>; Sun,  2 Aug 2020 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B40206E7
	for <linux-pwm@archiver.kernel.org>; Sun,  2 Aug 2020 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs24Kwr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHBTnJ (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:43:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32043 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725910AbgHBTnJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Aug 2020 15:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596397387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4/Mw3KkAAcPCK4zYXwpvO5LLtv+hmKDZL07Q/dYPuw=;
        b=gs24Kwr2cuXfGZopPInP9zPTHjYq5/zYWU8aonpwh4ZzUR/Cjg5eq0/5w47rvFymoebUyD
        bTvZ+4lTODe3FcX+iLGEGlL/wSzOAvjxCAJcaRqHNVaGdjwl4fn/yFbpexvv58XPNhHMc0
        7X5WPRemuBYq7WtOsB+9hZpagSAIcFc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-VQneaFAPNqK_KG9MjQoC2w-1; Sun, 02 Aug 2020 15:43:05 -0400
X-MC-Unique: VQneaFAPNqK_KG9MjQoC2w-1
Received: by mail-ed1-f70.google.com with SMTP id t9so10704431edw.22
        for <linux-pwm@vger.kernel.org>; Sun, 02 Aug 2020 12:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4/Mw3KkAAcPCK4zYXwpvO5LLtv+hmKDZL07Q/dYPuw=;
        b=EZr+Uu2CPM0RuysfayCN7GwE4Hi6CrdJkHedyIbNVfWOpzYUyqnPo8LVKcHnELlJgf
         BJZ+6fEAAvwX1zdbi+pOgsWzqZIOgPnJGEWDO+Lcc8mniVWKZoki6TM9koaUZHthW7dJ
         wZIjyleR+MhdGjfl9wGbX0L9QYBzi/MUVJWBiRzxu8yLXdwCDhtnxUfBCDkPu5MBKjr8
         r6nZH2vAuC3TF1MzNFBomlOenhLsIjdgwY05FxsovUWzkGqhpOlQhjlkpEbqIQfSAHcP
         Fn1+OEdVwdm15+L/0+orItjtMSHOKTrYdC7h+iy3SS0K6oUFRmRQlGV7lfBIR2r2/pB4
         wEOQ==
X-Gm-Message-State: AOAM53215zwIwQ8vFUFvtMC7V8Th7dLidVIpM5xNmJUohf351nMa6HNu
        kECpzzvh3JKtSgzD+LJ+DbhSAfcieK5ZjHr1FlC/ID0IFzmnNCiq9sNmlqxYRRj1SvpfQtfuMJk
        ZbkbMHkcTYs0eplJlamly
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr13098221eds.226.1596397384487;
        Sun, 02 Aug 2020 12:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynUhl0t0uuVDdTx6s58FiK7ReUpSYAlLkZ1s/9i/K4l82iijURkAOZIpAIJo7qPwgJDtnWkQ==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr13098209eds.226.1596397384275;
        Sun, 02 Aug 2020 12:43:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id ay5sm14253189edb.2.2020.08.02.12.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 12:43:03 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200729105436.GT3703480@smile.fi.intel.com>
 <e8f93474-1775-b20c-f9f2-e33592a02028@redhat.com>
 <20200802112524.GS3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3d66505a-3550-e81f-d6dc-250dba87e820@redhat.com>
Date:   Sun, 2 Aug 2020 21:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802112524.GS3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 8/2/20 1:25 PM, Andy Shevchenko wrote:
> On Sat, Aug 01, 2020 at 04:38:16PM +0200, Hans de Goede wrote:
>> On 7/29/20 12:54 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
> 
> ...
> 
>>> One comment to consider, though. There are three channels in that PWM AFAIU.
>>> One of them is backlight control, another one can be attached to haptics. The
>>> concern is how this series may (or may not?) affect haptics behaviour.
>>
>> When you say "in that PWM" do you mean the LPSS one or the CRC one ?
> 
> CRC one. I have read it from PMIC spec, that's why the question.

Ah I see, well the kernel driver only implements support for 1 PWM output,
the one which is used for the backlight brighness control.

So this series should not affect haptics behavior, since it looks like
the haptic functionality is not supported in the mainline kernel at all.

And I'm also not aware of any tablets with a CRC PMIC which have
(non working) haptic support.

Regards,

Hans

