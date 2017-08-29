From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH] pwm_bl: Fix overflow condition
Date: Tue, 29 Aug 2017 13:34:23 -0700
Message-ID: <CAGAzgspcO5WQe55_F06K2D5rJ3H1-1u8Q1k-xPAZnkwr61pR_Q@mail.gmail.com>
References: <20170829202747.5698-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:32794 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdH2UeY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Aug 2017 16:34:24 -0400
Received: by mail-yw0-f172.google.com with SMTP id s143so22560371ywg.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Aug 2017 13:34:24 -0700 (PDT)
In-Reply-To: <20170829202747.5698-1-dbasehore@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, jingoohan1@gmail.com, Lee Jones <lee.jones@linaro.org>, briannorris@chromium.org, linux-pwm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>

Did not mean to send this in-reply to. It seems that git send-email
was not applying my "PATCH v2" prefix. Will resend as a separate
thread.
