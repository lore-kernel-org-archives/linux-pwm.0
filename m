From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH -next] pwm: sifive: Remove redundant dev_err call in
 pwm_sifive_probe()
Date: Wed, 4 Sep 2019 17:40:22 +0530
Message-ID: <CAJ2_jOHMu3V=wv7mThSw0A6wMkE1N_=sN3_8PjEOw+cLPO94NA@mail.gmail.com>
References: <20190904111836.122616-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190904111836.122616-1-weiyongjun1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-pwm@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, kernel-janitors@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Sep 4, 2019 at 4:31 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pwm/pwm-sifive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Yash Shah <yash.shah@sifive.com>
