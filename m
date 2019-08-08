Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36283 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbfHHJzz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 05:55:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so9044571ljj.3
        for <linux-pwm@vger.kernel.org>; Thu, 08 Aug 2019 02:55:53 -0700 (PDT)
References: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
Date: Thu, 8 Aug 2019 12:55:40 +0300
MIME-Version: 1.0
In-Reply-To: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello!

On 08.08.2019 9:38, Yoshihiro Shimoda wrote:

> Since the rcar_pwm_apply() has already check whehter state->enabled

    Checked?

> is not set or not, this patch removes a redundant condition.

    Is set or not?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
[...]

MBR, Sergei
