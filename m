Return-Path: <axel.lin@ingics.com>
MIME-Version: 1.0
In-Reply-To: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
References: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
Date: Tue, 25 Jun 2013 10:59:08 +0800
Message-ID: <CAFRkauDYqE6=kNcn9QxY7L9mStbSwiKtupW5T-YUToY5=xt2SA@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: renesas-tpu: fix return value check in tpu_probe()
From: Axel Lin <axel.lin@ingics.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: thierry.reding@gmail.com, laurent.pinchart+renesas@ideasonboard.com, yongjun_wei@trendmicro.com.cn, linux-pwm@vger.kernel.org

2013/6/25 Wei Yongjun <weiyj.lk@gmail.com>:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---

Reviewed-by: Axel Lin <axel.lin@ingics.com>
