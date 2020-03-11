From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v8 10/12] pwm: sun4i: Use 64-bit division function
Date: Wed, 11 Mar 2020 11:35:07 +0800
Message-ID: <CAGb2v65udRk8A6-ZBT8MRo9SUmhc-9i7PeVBi0UTtNMTx_QbKw@mail.gmail.com>
References: <cover.1583889178.git.gurus@codeaurora.org> <d2d973f90eb1bbbcddf5dabaa99659dacf721744.1583889178.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44528 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCKDfW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 23:35:22 -0400
In-Reply-To: <d2d973f90eb1bbbcddf5dabaa99659dacf721744.1583889178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>

On Wed, Mar 11, 2020 at 9:41 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
