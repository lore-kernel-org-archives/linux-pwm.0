From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 3/3] pwm: sun4i: drop legacy callbacks
Date: Sat, 10 Jun 2017 00:22:40 +0800
Message-ID: <CAGb2v64sL=uJtLmtEeGcbAMrgsEmKDsca0f2+HfDS18jZeMjqQ@mail.gmail.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com> <20170530193209.19247-4-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:55008 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdFIQXE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Jun 2017 12:23:04 -0400
In-Reply-To: <20170530193209.19247-4-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, May 31, 2017 at 3:32 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Remove the legacy callbacks .enable(), .disable(), .set_polarity() and
> .config().
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

FWIW,

Acked-by: Chen-Yu Tsai <wens@csie.org>
